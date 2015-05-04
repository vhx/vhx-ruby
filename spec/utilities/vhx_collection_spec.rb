require 'spec_helper'

describe Vhx::VhxCollection do
  let(:sample_hash_collection){ JSON.parse(File.read("spec/fixtures/sample_hash_collection.json")) }
  let(:sample_array_collection){ JSON.parse(File.read("spec/fixtures/sample_array_collection.json")) }

  context 'hash collection' do
    it 'has #previous, #next methods based on _links' do
      expect(Vhx::VhxCollection.new(sample_hash_collection, 'files').next).to eq 'pending'
      expect(Vhx::VhxCollection.new(sample_hash_collection, 'files').previous).to eq 'pending'
    end

    it 'makes call to url in #previous, #next' do
      pending
    end

    it 'builds array from _embedded' do
      expect(Vhx::VhxCollection.new(sample_hash_collection, 'files').kind_of?(Array)).to eq true
    end
  end

  context 'array collection' do
    it 'builds array from parameter' do
      expect(Vhx::VhxCollection.new(sample_array_collection, 'files').kind_of?(Array)).to eq true
    end
  end
end
