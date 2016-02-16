module Vhx
  class Customer < VhxObject
    include Vhx::ApiOperations::Create
    include Vhx::ApiOperations::Request
    include Vhx::ApiOperations::List
    include Vhx::ApiOperations::Delete

    def add_product(identifier)
      response = Vhx.connection.put do |req|
        req.url('/customers/' + self.id.to_s + '/products')
        req.body = { product: get_hypermedia(identifier, 'Product') }
      end

      self.class.new(response.body)
    end

    def remove_product(identifier)
      response = Vhx.connection.delete do |req|
        req.url('/customers/' + self.id.to_s + '/products')
        req.body = { product: get_hypermedia(identifier, 'Product') }
      end

      self.class.new(response.body)
    end
  end
end