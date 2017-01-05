require 'spec_helper'

describe Vhx::Video::File do
  before{
    Vhx.setup({api_key: 'testapikey'})
  }

  describe 'api operations' do

    describe '::find' do
      it 'raises error' do
        expect{Vhx::Video::File.find(123)}.to raise_error(NoMethodError)
      end
    end 

    describe '::retrieve' do
      it 'raises error' do
        expect{Vhx::Video::File.retrieve(123)}.to raise_error(NoMethodError)
      end
    end

    describe '::list' do
      it 'raises error' do
        expect{Vhx::Video::File.list()}.to raise_error(NoMethodError)
      end
    end

    describe '::all' do
      it 'raises errors' do
        expect{Vhx::Video::File.all()}.to raise_error(NoMethodError)
      end
    end

    describe '::create' do
      it 'raises error' do
        expect{Vhx::Video::File.create()}.to raise_error(NoMethodError)
      end
    end

    describe '#udpate' do
      it 'raises error' do
        expect{Vhx::Video::File.new({}).update}.to raise_error(NoMethodError)
      end
    end

    describe '::delete' do
      it 'raises error' do
        expect{Vhx::Video::File.delete(1)}.to raise_error(NoMethodError)
      end
    end
  end
end
