require 'spec_helper'

describe Vhx::Authorization do

  before{
    Vhx.setup({api_key: 'testapikey'})
  }

  describe 'api operations' do

    describe '::find' do
      it 'raises error' do
        expect{Vhx::Authorization.find(123)}.to raise_error(NoMethodError)
      end
    end 

    describe '::retrieve' do
      it 'raises error' do
        expect{Vhx::Authorization.retrieve(123)}.to raise_error(NoMethodError)
      end
    end

    describe '::list' do
      it 'raises error' do
        expect{Vhx::Authorization.list()}.to raise_error(NoMethodError)
      end
    end

    describe '::all' do
      it 'raises errors' do
        expect{Vhx::Authorization.all()}.to raise_error(NoMethodError)
      end
    end

    describe '::create' do
      def authorization_response
        JSON.parse(File.read("spec/fixtures/sample_authorization_response.json"))
      end

      it 'does not error' do
        Vhx.connection.stub(:post).and_return(OpenStruct.new(body: authorization_response))
        expect{Vhx::Authorization.create({})}.to_not raise_error
      end
    end

    describe '#udpate' do
      it 'raises error' do
        expect{Vhx::Authorization.new({}).update}.to raise_error(NoMethodError)
      end
    end

    describe '::delete' do
      it 'raises error' do
        expect{Vhx::Authorization.delete(1)}.to raise_error(NoMethodError)
      end
    end
  end
end
