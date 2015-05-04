require 'spec_helper'

describe Vhx::Site, :vcr do
  let(:sample_site_response){ JSON.parse(File.read("spec/fixtures/sample_site_response.json")) }
  let(:vhx_site){Vhx::Site.new(sample_site_response)}

  before {
    Vhx.setup(test_credentials)
  }

  describe '::find' do
    it 'with id' do
      expect(Vhx::Site.find(1900)).to be_instance_of(Vhx::Site)
    end

    it 'with hypermedia' do
      expect(Vhx::Site.find('http://api.crystal.dev/sites/1900')).to be_instance_of(Vhx::Site)
    end
  end

  describe '::create' do
    it 'returns site object' do
      attributes = {title: 'Gem New Site', description: 'For testing gem'}
      expect(Vhx::Site.create(attributes)).to be_instance_of(Vhx::Site)
    end
  end

  describe '#add_follower' do
    context 'with email address' do
      it 'returns site object' do
        expect(vhx_site.add_follower('foo@bar.foobar')).to be_instance_of(Vhx::Site)
      end
    end

    context 'with id' do
      it 'returns site object' do
        expect(vhx_site.add_follower(1)).to be_instance_of(Vhx::Site)
      end
    end

    context 'with hypermedia' do
      it 'returns site object' do
        expect(vhx_site.add_follower('http://api.crystal.dev/users/1')).to be_instance_of(Vhx::Site)
      end
    end
  end

  describe '#remove_follower' do
    it 'returns site object' do
      expect(vhx_site.remove_follower).to be_instance_of(Vhx::Site)
    end
  end

  describe 'attributes' do
    it 'are present' do
      expect(vhx_site.id).to_not be_nil
      expect(vhx_site.title).to_not be_nil
    end
  end

  describe 'associations' do
    it 'are present' do
      expect{vhx_site.packages}.to_not raise_error(NoMethodError)
      expect{vhx_site.followers}.to_not raise_error(NoMethodError)
    end

    it 'errors if not present' do
      expect{vhx_site.site}.to raise_error(NoMethodError)
    end
  end
end