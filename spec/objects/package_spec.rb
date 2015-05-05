require 'spec_helper'

describe Vhx::Package, :vcr do
  let(:sample_package_response){ JSON.parse(File.read("spec/fixtures/sample_package_response.json")) }
  let(:vhx_package){Vhx::Package.new(sample_package_response)}

  before {
    Vhx.setup(test_credentials)
  }

  describe '::find' do
    it 'with id' do
      expect(Vhx::Package.find(1025)).to be_instance_of(Vhx::Package)
    end

    it 'with hypermedia' do
      expect(Vhx::Package.find('http://api.crystal.dev/packages/1025')).to be_instance_of(Vhx::Package)
    end
  end

  describe '::create' do
    it 'returns package object' do
      attributes = {title: 'test package', description: 'test description', price_cents: 1000, site: "http://api.crystal.dev/sites/1900"}
      expect(Vhx::Package.create(attributes)).to be_instance_of(Vhx::Package)
    end
  end

  describe '#add_video' do
    context 'with id' do
      it 'returns package object' do
        expect(vhx_package.add_video(7830)).to be_instance_of(Vhx::Package)
      end
    end

    context 'with hypermedia' do
      it 'returns package object' do
        expect(vhx_package.add_video('http://api.crystal.dev/videos/7830')).to be_instance_of(Vhx::Package)
      end
    end
  end

  describe '#remove_video' do
    context 'with id' do
      it 'returns success' do
        expect(vhx_package.remove_video(7726)).to be_instance_of(Vhx::Package)
      end
    end

    context 'with hypermedia' do
      it 'returns success' do
        expect(vhx_package.remove_video('http://api.crystal.dev/videos/7726')).to be_instance_of(Vhx::Package)
      end
    end
  end

  describe 'attributes' do
    it 'are present' do
      expect(vhx_package.id).to_not be_nil
      expect(vhx_package.title).to_not be_nil
    end
  end

  describe 'associations' do
    it 'are present' do
      expect{vhx_package.site}.to_not raise_error(NoMethodError)
      expect{vhx_package.videos}.to_not raise_error(NoMethodError)
    end

    it 'errors if not present' do
      expect{vhx_package.package}.to raise_error(NoMethodError)
    end
  end

end