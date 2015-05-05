require 'spec_helper'

describe Vhx::Middleware::ErrorResponse, :vcr do
  before{
    Vhx.setup(unauthorized_user_credentials)
  }

  it 'unauthorized_user_credentials' do
    expect{Vhx::User.me}.to raise_error(Vhx::UnauthorizedError)
  end
end