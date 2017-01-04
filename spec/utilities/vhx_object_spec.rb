require 'spec_helper'

describe Vhx::VhxObject do

  def customer_response
    JSON.parse(File.read("spec/fixtures/sample_customer_response.json")) 
  end
  
  def products_response
    JSON.parse(File.read("spec/fixtures/sample_products_response.json")) 
  end

  def customer
    Vhx::Customer.new(customer_response)
  end

  describe '#to_json' do
    it 'returns json' do
      expect(customer.to_json.class).to be(String)
    end
  end

  describe '#to_hash' do
    it 'returns object as a hash' do
      expect(customer.to_hash.class).to be(Hash)
    end
  end

  describe '#href' do
    it 'returns the href of the object' do
      expect(customer.href).to match("https://api.vhx.tv/customers")
    end
  end

  describe '#links' do
    it 'returns links object' do
      expect(customer.links.self).to match("https://api.vhx.tv/customers")
    end
  end

  describe '#_links' do
    it 'returns raw _links hash' do
      expect(customer._links['self']['href']).to match("https://api.vhx.tv/customers")
    end
  end
  
  describe '#_embedded' do
    it 'returns raw _embedded hash' do
      expect(customer._embedded.keys).to include('products')
    end
  end

  describe '#validate_class' do
    it 'raises error' do
      expect{Vhx::VhxObject.new(customer_response)}.to raise_error(Vhx::InvalidResourceError)
    end

    it 'succeeds' do
      expect(Vhx::Customer.new(customer_response)).to be_instance_of(Vhx::Customer)
    end
  end

  describe 'associations' do
    before {
      Vhx.setup({api_key: 'testapikey'})
    }

    it 'default to embedded' do
      Vhx.connection.stub(:get)
      customer = Vhx::Customer.new(customer_response)
      products = customer.products
      expect(products).to be_instance_of Vhx::VhxListObject
      expect(Vhx.connection).to_not have_received(:get)
    end

    it 'falls back to links' do
      Vhx.connection.stub(:get).and_return(OpenStruct.new(body: products_response))
      customer_no_embedded = customer_response
      customer_no_embedded['_embedded'] = {}
      customer = Vhx::Customer.new(customer_no_embedded)

      products = customer.products
      
      expect(products).to be_instance_of Vhx::VhxListObject
      expect(Vhx.connection).to have_received(:get).exactly(1).times
    end

    describe 'has_many' do
      it 'returns VhxListObject object' do
        customer = Vhx::Customer.new(customer_response)
        products = customer.products
        expect(products).to be_instance_of Vhx::VhxListObject
      end
    end
  end
end
