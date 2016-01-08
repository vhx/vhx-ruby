module Vhx
  class User < VhxObject
    include Vhx::ApiOperations::Request

    def self.me
      response_json = Vhx.connection.get('/me').body
      self.new(response_json)
    end
  end
end
