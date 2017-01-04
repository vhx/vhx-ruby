require 'spec_helper'

describe Vhx::Customer do
  def customer_response
    JSON.parse(File.read("spec/fixtures/sample_customer_response.json"))
  end

  def customers_response
    JSON.parse(File.read("spec/fixtures/sample_customers_response.json"))
  end

  before{
    Vhx.setup({api_key: 'testapikey'})
  }
  
  describe 'api operations' do

    describe '::find' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: customer_response))
        expect{Vhx::Customer.find(123)}.to_not raise_error 
      end
    end 

    describe '::retrieve' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: customer_response))
        expect{Vhx::Customer.retrieve(123)}.to_not raise_error 
      end
    end

    describe '::list' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: customers_response))
        expect{Vhx::Customer.list()}.to_not raise_error 
      end
    end

    describe '::all' do
      it 'does not error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: customers_response))
        expect{Vhx::Customer.all()}.to_not raise_error 
      end
    end

    describe '::create' do
      it 'does not error' do
        Vhx.connection.stub(:post).and_return(OpenStruct.new(body: customers_response))
        expect{Vhx::Customer.create({})}.to_not raise_error
      end
    end

    describe '#udpate' do
      it 'raises error' do
        expect{Vhx::Customer.new(customer_response).update}.to raise_error(NoMethodError)
      end
    end

    describe '::delete' do
      it 'does not error' do
        Vhx.connection.stub(:delete).and_return(OpenStruct.new(body: ""))
        expect{Vhx::Customer.delete(1)}.to_not raise_error
      end
    end

    describe '#add_product' do
      it 'returns customer' do
        Vhx.connection.stub(:put).and_return(OpenStruct.new(body: customer_response))
        customer = Vhx::Customer.new(customer_response).add_product(1)
        expect(customer.class).to eq(Vhx::Customer) 
      end
    end

    describe '#remove_product' do
      it 'returns customer' do
        Vhx.connection.stub(:delete).and_return(OpenStruct.new(body: customer_response))
        customer = Vhx::Customer.new(customer_response).remove_product(1)
        expect(customer.class).to eq(Vhx::Customer) 
      end
    end
  end
end
