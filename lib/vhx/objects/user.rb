module Vhx
  class User < VhxObject
    def self.me
      response = Vhx.connection.get('/me').body
      self.new(response)
    end
  end
end
