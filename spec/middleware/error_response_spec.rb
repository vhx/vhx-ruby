require 'spec_helper'

describe Vhx::Middleware::ErrorResponse, :vcr do
  xit 'unauthorized_user_credentials' do
    expect{Vhx::Customer.find(1)}.to raise_error(Vhx::UnauthorizedError)
  end
end
