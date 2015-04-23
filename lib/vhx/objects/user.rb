module Vhx
  class User < VhxObject

    extend ApiOperations

    def self.me
      response_json = Vhx.connection.get('/me').body
      self.new(response_json)
    end
  end
end
