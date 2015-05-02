require 'spec_helper'

describe Vhx::VhxObject do
  let(:sample_user_response){ JSON.parse(File.read("spec/fixtures/sample_user_response.json")) }

  describe '#validate_class' do
    it 'raises error' do
      expect{Vhx::VhxObject.new(sample_user_response)}.to raise_error(Vhx::InvalidResourceError)
    end

    it 'succeeds' do
      expect(Vhx::User.new(sample_user_response)).to be_instance_of(Vhx::User)
    end
  end

  describe '#create_accessors' do
    expect(Vhx::User.new(sample_user_response)).to be_instance_of(Vhx::User)
  end
end