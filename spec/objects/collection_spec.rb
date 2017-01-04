require 'spec_helper'

describe Vhx::Collection do
  def collection_response
    JSON.parse(File.read("spec/fixtures/sample_collection_response.json"))
  end

  def collections_response
    JSON.parse(File.read("spec/fixtures/sample_collections_response.json"))
  end

  before{
    Vhx.setup({api_key: 'testapikey'})
  }
  
  describe 'api operations' do

    describe '::find' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: collection_response))
        expect{Vhx::Collection.find(123)}.to_not raise_error 
      end
    end 

    describe '::retrieve' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: collection_response))
        expect{Vhx::Collection.retrieve(123)}.to_not raise_error 
      end
    end

    describe '::list' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: collections_response))
        expect{Vhx::Collection.list()}.to_not raise_error 
      end
    end

    describe '::all' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: collections_response))
        expect{Vhx::Collection.all()}.to_not raise_error 
      end
    end

    describe '::create' do
      it 'does not error' do
        Vhx.connection.stub(:post).and_return(OpenStruct.new(body: collections_response))
        expect{Vhx::Collection.create({})}.to_not raise_error
      end
    end

    describe '#udpate' do
      it 'does not error' do
        Vhx.connection.stub(:put).and_return(OpenStruct.new(body: collections_response))
        expect{Vhx::Collection.new(collection_response).update({})}.to_not raise_error
      end
    end

    describe '::delete' do
      it 'raises error' do
        expect{Vhx::Collection.delete(1)}.to raise_error(NoMethodError)
      end
    end
  end
end
