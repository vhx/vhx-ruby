require 'spec_helper'

describe Vhx::VhxObject, :vcr do
  let(:sample_package_response){ JSON.parse(File.read("spec/fixtures/sample_package_response.json")) }
  let(:vhx_object_with_embedded){Vhx::Package.new(sample_package_response)}
  let(:vhx_object_without_embedded){sample_package_response['_embedded'] = {}; Vhx::Package.new(sample_package_response);}

  describe '#validate_class' do
    it 'raises error' do
      expect{Vhx::VhxObject.new(sample_package_response)}.to raise_error(Vhx::InvalidResourceError)
    end

    it 'succeeds' do
      expect(Vhx::Package.new(sample_package_response)).to be_instance_of(Vhx::Package)
    end
  end

  describe 'associations' do
    before {
      Vhx.setup(test_credentials)
    }

    it 'default to embedded' do
      Faraday::Connection.any_instance.should_not_receive(:get)
      expect(vhx_object_with_embedded.site).to be_instance_of Vhx::Site
    end

    it 'falls back to links' do
      Faraday::Connection.any_instance.should_receive(:get).and_call_original
      expect(vhx_object_without_embedded.site).to be_instance_of Vhx::Site
    end

    describe 'cache' do
      it 'retreive if available' do
        vhx_object_without_embedded.site
        Faraday::Connection.any_instance.should_not_receive(:get)
        expect(vhx_object_without_embedded.site).to be_instance_of Vhx::Site
      end
    end

    describe 'has_many' do
      it 'returns VhxCollection object' do
        expect(vhx_object_with_embedded.videos).to be_instance_of Vhx::VhxCollection
      end
    end

    describe 'has_one' do
      it 'returns resource object' do
        expect(vhx_object_with_embedded.site).to be_instance_of Vhx::Site
      end
    end
  end
end