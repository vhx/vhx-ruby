require 'spec_helper'

describe Vhx::Client do
  let(:application_only_credentials){{api_key: "-HyMMMvuWsXSezKvYFJ1N_1xRe9dymeh"}}

  let(:application_user_credentials){
    {
      client_id: '7ed37300580e27f1acb5f16112e91aba43931d1e8e8c9829cc0fc36358f2cd44',
      client_secret: 'ce0fc20cad4cb74b4e5c30803446066b6d8556f413217a6a102aaab03372ac77',
      oauth_token: {
        access_token:  "0db809806968cb57e8d9bf1193a897a4d2fd776162c440cd0117dd6e769dac39",
        refresh_token: nil,
        expires_at:    1429741721
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

    describe '#refresh_token' do
    end
  end
end