require 'spec_helper'

describe Vhx::File do
  let(:sample_file_response){ JSON.parse(File.read("spec/fixtures/sample_file_response.json")) }
  let(:vhx_file){Vhx::File.new(sample_file_response)}

  describe 'attributes' do
    it 'are present' do
      expect(vhx_file.created_at).to_not be_nil
      expect(vhx_file.quality).to_not be_nil
      expect(vhx_file.mime_type).to_not be_nil
    end
  end

  describe 'associations' do
    it 'are present' do
      expect(vhx_file.video).to_not be_nil
      expect(vhx_file.site).to_not be_nil
    end

    it 'errors if not present' do
      expect(vhx_file.file).to raise_error(NoMethodError)
    end
  end
end