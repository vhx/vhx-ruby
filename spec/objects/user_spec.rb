require 'spec_helper'

describe Vhx::User do
  let(:sample_user_response){ JSON.parse(File.read("spec/fixtures/sample_user_response.json")) }
  let(:vhx_user){Vhx::User.new(sample_user_response)}

  before {
    Vhx.setup(test_credentials)
  }

  describe '::find', :vcr do
    it 'with id' do
      expect(Vhx::User.find(1560703)).to be_instance_of(Vhx::User)
    end

    it 'with hypermedia' do
      expect(Vhx::User.find('http://api.crystal.dev/users/1560703')).to be_instance_of(Vhx::User)
    end
  end

  describe '::me', :vcr do
    it 'returns user object' do
      expect(Vhx::User.me).to be_instance_of(Vhx::User)
    end
  end

  describe '#update', :vcr do
    it 'returns user object' do
      vhx_user.update(name: 'Test Name')
      expect(vhx_user.name).to eq 'Test Name'
    end
  end

  describe 'attributes' do
    it 'are present' do
      expect(vhx_user.id).to_not be_nil
      expect(vhx_user.name).to_not be_nil
    end
  end

  describe 'associations' do
    it 'are present' do
      expect{vhx_user.packages}.to_not raise_error(NoMethodError)
      expect{vhx_user.sites}.to_not raise_error(NoMethodError)
    end

    it 'errors if not present' do
      expect{vhx_user.users}.to raise_error(NoMethodError)
    end
  end
end