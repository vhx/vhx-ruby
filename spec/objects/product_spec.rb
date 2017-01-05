require 'spec_helper'

describe Vhx::Product do

  def product_response
    JSON.parse(File.read("spec/fixtures/sample_product_response.json"))
  end

  def products_response
    JSON.parse(File.read("spec/fixtures/sample_products_response.json"))
  end
  
  before{
    Vhx.setup({api_key: 'testapikey'})
  }

  describe 'api operations' do

    describe '::find' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: product_response))
        expect{Vhx::Product.find(123)}.to_not raise_error 
      end
    end 

    describe '::retrieve' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: product_response))
        expect{Vhx::Product.retrieve(123)}.to_not raise_error 
      end
    end

    describe '::list' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: products_response))
        expect{Vhx::Product.list()}.to_not raise_error 
      end
    end

    describe '::all' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: products_response))
        expect{Vhx::Product.all()}.to_not raise_error 
      end
    end

    describe '::create' do
      it 'raises error' do
        expect{Vhx::Product.create()}.to raise_error(NoMethodError)
      end
    end

    describe '#udpate' do
      it 'raises error' do
        expect{Vhx::Product.new({}).update}.to raise_error(NoMethodError)
      end
    end

    describe '::delete' do
      it 'raises error' do
        expect{Vhx::Product.delete(1)}.to raise_error(NoMethodError)
      end
    end
  end
end
