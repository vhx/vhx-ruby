require 'spec_helper'

describe Vhx::Middleware::OAuth2 do
  # All local data and not sensitive.
  let(:expired_application_user_credentials){
    {
      client_id: '7ed37300580e27f1acb5f16112e91aba43931d1e8e8c9829cc0fc36358f2cd44',
      client_secret: 'ce0fc20cad4cb74b4e5c30803446066b6d8556f413217a6a102aaab03372ac77',
      oauth_token: {
        access_token:  "32074db67cf99ea06c83cba3b425bb63ad805c156c6ecb0f5ef3f69d7bd8711f",
        refresh_token: "1dde8328275c9cf643ab6f39eb764e87dfb1a705641d634f252dd9862b3e3a97",
        expires_at: 1430330123,
        expires_in: 1
      }
    }
  }

  subject(:vhx_connection){ Vhx::Client.new(application_user_credentials).connection}

  it 'access_token refresh', :vcr do
    Vhx::Client.any_instance.should_receive(:expired_application_user_credentials)
    vhx_connection.get('/me')
  end
end