require 'spec_helper'

describe Vhx::Video do
  let(:sample_video_response){ JSON.parse(File.read("spec/fixtures/sample_video_response.json")) }
  let(:vhx_video){Vhx::Video.new(sample_video_response)}
  let(:credentials){ JSON.parse(File.read("spec/fixtures/test_credentials.json")) }

  before {
    Vhx.setup(credentials)
  }

  describe '::create' do
    it 'returns video object' do
      expect(Vhx::Video.create({})).to be_instance_of(Vhx::Video)
    end
  end

  describe 'attributes' do
    it 'are present' do
      expect(vhx_video.id).to_not be_nil
      expect(vhx_video.title).to_not be_nil
    end
  end

  describe 'associations' do
    it 'are present' do
      expect(vhx_video.files).to_not be_nil
      expect(vhx_video.site).to_not be_nil
    end

    it 'errors if not present' do
      expect{vhx_video.videos}.to raise_error(NoMethodError)
    end
  end

end