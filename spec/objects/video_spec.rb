require 'spec_helper'

describe Vhx::Video do

  def video_response
    JSON.parse(File.read("spec/fixtures/sample_video_response.json"))
  end

  def videos_response
    JSON.parse(File.read("spec/fixtures/sample_videos_response.json"))
  end

  before{
    Vhx.setup({api_key: 'testapikey'})
  }
  
  describe 'api operations' do

    describe '::find' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: video_response))
        expect{Vhx::Video.find(123)}.to_not raise_error 
      end
    end 

    describe '::retrieve' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: video_response))
        expect{Vhx::Video.retrieve(123)}.to_not raise_error 
      end
    end

    describe '::list' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: videos_response))
        expect{Vhx::Video.list()}.to_not raise_error 
      end
    end

    describe '::all' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: videos_response))
        expect{Vhx::Video.all()}.to_not raise_error 
      end
    end

    describe '::create' do
      it 'raises error' do
        Vhx.connection.stub(:post).and_return(OpenStruct.new(body: videos_response))
        expect{Vhx::Video.create({})}.to_not raise_error
      end
    end

    describe '#udpate' do
      it 'raises error' do
        Vhx.connection.stub(:put).and_return(OpenStruct.new(body: video_response))
        expect{Vhx::Video.new(video_response).update({})}.to_not raise_error(NoMethodError)
      end
    end

    describe '::delete' do
      it 'raises error' do
        expect{Vhx::Video.delete(1)}.to raise_error(NoMethodError)
      end
    end

    describe '#files' do

      def files_response
        JSON.parse(File.read("spec/fixtures/sample_files_response.json"))
      end
      
      it 'fetches linked association' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: files_response))
        files = Vhx::Video.new(video_response).files
        expect(files.first.class).to eq(Vhx::Video::File) 
        expect(Vhx.connection).to have_received(:get)
      end
    end
  end
end
