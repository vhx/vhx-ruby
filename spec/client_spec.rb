require 'spec_helper'

describe Vhx::Client, :vcr do
  describe 'faraday configuration' do
    subject(:vhx_client){ Vhx::Client.new(application_only_credentials)}

    it 'uses custom error response middleware' do
      expect(vhx_client.connection.builder.handlers).to include(Vhx::Middleware::ErrorResponse)
    end

    it 'uses api host' do
      expect(vhx_client.connection.url_prefix.host).to eq 'api.crystal.dev'
    end
  end

  context 'application_only' do
    subject(:vhx_client){ Vhx::Client.new(application_only_credentials)}

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
    subject(:vhx_client){ Vhx::Client.new(application_user_credentials)}

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
      subject(:oauth_token){ vhx_client.oauth_token }
      let!(:original_access_token){ oauth_token.access_token }
      before { vhx_client.refresh_access_token! }

      it 'oauth_token refreshed' do
        expect(vhx_client.oauth_token.refreshed).to eq(true)
      end

      it 'access_token changed' do
        expect(vhx_client.oauth_token.access_token).to_not eq(original_access_token)
      end
    end
  end
end