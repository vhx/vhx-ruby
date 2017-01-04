require 'spec_helper'

describe Vhx::HelperMethods do
  let(:user_response){ JSON.parse(File.read("spec/fixtures/sample_user_response.json")) }
  let(:vhx_object){Vhx::User.new(user_response)}

  before{
    Vhx.setup({api_key: 'testapikey'})
  }

  describe '#get_klass' do
    context 'class method' do
      it 'determines class' do
        expect(Vhx::User.get_klass).to eq('User')
      end
    end

    context 'instance method' do
      it 'determines class' do
        expect(vhx_object.get_klass).to eq('User')
      end
    end
  end

  describe '#get_hypermedia' do
    context 'hypermedia parameter' do
      it 'returns hypermedia parameter' do
        resource_url = 'https://api.vhx.tv/users/1560703'
        expect(Vhx::User.get_hypermedia(resource_url)).to eq(resource_url)
      end
    end

    context 'id parameter' do
      it 'converts to hypermedia path' do
        expect(vhx_object.get_hypermedia(1560703)).to eq 'https://api.vhx.tv/users/1560703'
      end

      context 'klass specified' do
        it 'applies klass parameter' do
          expect(vhx_object.get_hypermedia(1560703, 'Video')).to eq 'https://api.vhx.tv/videos/1560703'
        end
      end

      context 'klass not specified' do
        it 'determines klass' do
          expect(vhx_object.get_hypermedia(1560703)).to eq 'https://api.vhx.tv/users/1560703'
        end
      end
    end
  end
end
