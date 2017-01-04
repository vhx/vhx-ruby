require 'spec_helper'

describe Vhx::Middleware::OAuth2, :vcr do
  xit 'access_token refresh' do
    original_access_token = Vhx.client.oauth_token.access_token
    Vhx::Client.any_instance.should_receive(:refresh_access_token!).and_call_original
    Vhx::Customer.find(1)
    expect(Vhx.client.oauth_token.access_token).to_not eq original_access_token
  end
end
