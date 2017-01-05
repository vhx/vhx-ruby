require 'spec_helper'

describe Vhx::Client do
  def application_only_credentials
    {api_key: "-12345"}
  end

  def application_user_credentials
    {
      client_id: '12345',
      client_secret: '12345',
      oauth_token: {
        access_token:  "123456",
        refresh_token: "12345",
        expires_at: 1430330123,
        expires_in: 7200
      }
    }
  end

  describe 'faraday configuration' do
    let(:vhx_client){ Vhx::Client.new(application_only_credentials)}

    it 'uses custom error response middleware' do
      expect(vhx_client.connection.builder.handlers).to include(Vhx::Middleware::ErrorResponse)
    end

    it 'does not utilize oauth2 middleware by default' do
      expect(vhx_client.connection.builder.handlers).to_not include(Vhx::Middleware::OAuth2)
    end

    it 'utilizes oauth2 middleware if auto_refresh option passed' do
      credentials = application_only_credentials.merge(auto_refresh: true)
      vhx_client = Vhx::Client.new(credentials)
      expect(vhx_client.connection.builder.handlers).to include(Vhx::Middleware::OAuth2)
    end

    it 'uses api host' do
      expect(vhx_client.connection.url_prefix.host).to eq 'api.vhx.tv'
    end
  end

  context 'application_only' do
    let(:vhx_client){ Vhx::Client.new(application_only_credentials)}

    describe 'connection' do
      it 'initializes faraday connection' do
        expect(vhx_client.connection).to be_an_instance_of(Faraday::Connection)
      end

      it 'authorization header presence' do
        expect(vhx_client.connection.headers['Authorization']).to_not be_nil
      end

      it 'basic auth presence' do
        expect(vhx_client.connection.headers['Authorization']).to match /Basic/
      end
    end
  end

  context 'application_user' do
    let!(:vhx_client){ Vhx::Client.new(application_user_credentials)}

    it 'oauth_token presence' do
      expect(vhx_client.oauth_token).to be_an_instance_of(OAuthToken)
    end

    describe 'connection' do
      it 'initializes faraday connection' do
        expect(vhx_client.connection).to be_an_instance_of(Faraday::Connection)
      end

      it 'authorization header presence' do
        expect(vhx_client.connection.headers['Authorization']).to_not be_nil
      end

      it 'Bearer auth presence' do
        expect(vhx_client.connection.headers['Authorization']).to match /Bearer/
      end
    end

    describe '#refresh_access_token!' do
      let(:oauth_token){ vhx_client.oauth_token }

      it 'oauth_token refreshed' do
        new_token_hash = {access_token: '123', refresh_token: '456', expires_in: '3600'}
        new_token_response = OpenStruct.new(body: new_token_hash)
        Faraday::Connection.any_instance.stub(:post).and_return(new_token_response)
        original_access_token = oauth_token.access_token 
        vhx_client.refresh_access_token! 
        expect(vhx_client.oauth_token.refreshed).to eq(true)
      end

      it 'access_token changed' do
        new_token_hash = {access_token: '123', refresh_token: '456', expires_in: '3600'}
        new_token_response = OpenStruct.new(body: new_token_hash)
        Faraday::Connection.any_instance.stub(:post).and_return(new_token_response)
        original_access_token = oauth_token.access_token 
        vhx_client.refresh_access_token! 
        expect(vhx_client.oauth_token.access_token).to_not eq(original_access_token)
      end
    end
  end
end
