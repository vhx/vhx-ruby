require 'spec_helper'

describe Vhx::User do
  
  def user_response
    JSON.parse(File.read("spec/fixtures/sample_user_response.json"))
  end

  before{
    Vhx.setup({api_key: 'testapikey'})
  }

  describe 'api operations' do

    describe '::find' do
      it 'raises error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: user_response))
        expect{Vhx::User.find(123)}.to_not raise_error
      end
    end 

    describe '::retrieve' do
      it 'raises error' do
        Vhx.connection.stub(:get).and_return(OpenStruct.new(body: user_response))
        expect{Vhx::User.retrieve(123)}.to_not raise_error
      end
    end

    describe '::list' do
      it 'raises error' do
        expect{Vhx::User.list()}.to raise_error(NoMethodError)
      end
    end

    describe '::all' do
      it 'raises errors' do
        expect{Vhx::User.all()}.to raise_error(NoMethodError)
      end
    end

    describe '::create' do
      it 'raises error' do
        expect{Vhx::User.create()}.to raise_error(NoMethodError)
      end
    end

    describe '#udpate' do
      it 'raises error' do
        expect{Vhx::User.new({}).update}.to raise_error(NoMethodError)
      end
    end

    describe '::delete' do
      it 'raises error' do
        expect{Vhx::User.delete(1)}.to raise_error(NoMethodError)
      end
    end
  end
end
