require 'spec_helper'

describe Vhx::Collection::Item do

  before{
    Vhx.setup({api_key: 'testapikey'})
  }

  describe 'api operations' do

    describe '::find' do
      it 'raises error' do
        expect{Vhx::Collection::Item.find(123)}.to raise_error(NoMethodError)
      end
    end 

    describe '::retrieve' do
      it 'raises error' do
        expect{Vhx::Collection::Item.retrieve(123)}.to raise_error(NoMethodError)
      end
    end

    describe '::list' do
      it 'raises error' do
        expect{Vhx::Collection::Item.list()}.to raise_error(NoMethodError)
      end
    end

    describe '::all' do
      it 'raises errors' do
        expect{Vhx::Collection::Item.all()}.to raise_error(NoMethodError)
      end
    end

    describe '::create' do
      it 'raises error' do
        expect{Vhx::Collection::Item.create()}.to raise_error(NoMethodError)
      end
    end

    describe '#udpate' do
      it 'raises error' do
        expect{Vhx::Collection::Item.new({}).update}.to raise_error(NoMethodError)
      end
    end

    describe '::delete' do
      it 'raises error' do
        expect{Vhx::Collection::Item.delete(1)}.to raise_error(NoMethodError)
      end
    end
  end
end
