require 'spec_helper'

describe Vhx::VhxListObject do
  let(:sample_hash_list){ JSON.parse(File.read("spec/fixtures/sample_hash_list.json")) }
  let(:sample_array_list){ JSON.parse(File.read("spec/fixtures/sample_array_list.json")) }

  context 'hash list' do
    it 'has #previous, #next methods based on _links' do
      expect(Vhx::VhxListObject.new(sample_hash_list, 'files').next).to eq 'pending'
      expect(Vhx::VhxListObject.new(sample_hash_list, 'files').previous).to eq 'pending'
    end

    it 'makes call to url in #previous, #next' do
      pending
    end

    it 'builds array from _embedded' do
      expect(Vhx::VhxListObject.new(sample_hash_list, 'files').kind_of?(Array)).to eq true
    end
  end

  context 'array list' do
    it 'builds array from parameter' do
      expect(Vhx::VhxListObject.new(sample_array_list, 'files').kind_of?(Array)).to eq true
    end
  end
end
