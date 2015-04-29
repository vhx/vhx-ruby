require 'spec_helper'

describe Vhx::Client do
  # All local data and not sensitive.
  let(:application_only_credentials){{api_key: "-HyMMMvuWsXSezKvYFJ1N_1xRe9dymeh"}}
  let(:application_user_credentials){
    {
      client_id: '7ed37300580e27f1acb5f16112e91aba43931d1e8e8c9829cc0fc36358f2cd44',
      client_secret: 'ce0fc20cad4cb74b4e5c30803446066b6d8556f413217a6a102aaab03372ac77',
      oauth_token: {
        access_token:  "5eb4f0d3f9e6ef8a3afdf7f3d8288d5067d626f1904b73b5695e4f65104be1c2",
        refresh_token: "132916e95bacc977a7890b31bf608e3d641d8a5c19b4ff4ffcf50e5b4273ed99",
        expires_at: 1430330123,
        expires_in: 7200
      }
    }
  }

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

    describe '#refresh_access_token', :vcr do
      subject(:oauth_token){ vhx_client.oauth_token }
      let!(:original_access_token){ oauth_token.access_token }
      before { vhx_client.refresh_access_token }

      it 'oauth_token refreshed' do
        expect(vhx_client.oauth_token.refreshed).to eq(true)
      end

      it 'access_token changed' do
        expect(vhx_client.oauth_token.access_token).to_not eq(original_access_token)
      end
    end
  end
end