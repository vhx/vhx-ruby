require 'spec_helper'

describe Vhx::Package do
  let(:sample_package_response){ JSON.parse(File.read("spec/fixtures/sample_package_response.json")) }
  let(:vhx_package){Vhx::Package.new(sample_package_response)}
  let(:credentials){ JSON.parse(File.read("spec/fixtures/test_credentials.json")) }

  before {
    Vhx.setup(credentials)
  }

  describe '::find' do
    it 'with id' do
      expect(Vhx::Package.find(1900)).to be_instance_of(Vhx::Package)
    end

    it 'with hypermedia' do
      expect(Vhx::Package.find('http://api.crystal.dev/packages/1900')).to be_instance_of(Vhx::Package)
    end
  end

  describe '::create' do
    it 'returns package object' do
      expect(Vhx::Package.create(attributes).to be_instance_of(Vhx::Package))
    end
  end

  describe '#add_video' do
    it 'returns package object' do
      expect(vhx_package.add_video).to be_instance_of(Vhx::Package)
    end
  end

  describe '#remove_video' do
    it 'returns success' do
      expect(vhx_package.remove_video).to be_instance_of(Vhx::Package)
    end
  end

  describe 'attributes' do
    it 'are present' do
      expect(vhx_package.id).to_not be_blank
      expect(vhx_package.title).to_not be_blank
    end
  end

  describe 'associations' do
    it 'are present' do
      expect(vhx_package.site).to_not be_blank
      expect(vhx_package.videos).to_not be_blank
    end

    it 'errors if not present' do
      expect{vhx_package.package}.to raise_error(NoMethodError)
    end
  end

end