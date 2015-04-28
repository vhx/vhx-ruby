module Vhx
  class User < VhxObject

    include ApiOperations

    def self.me
      response_json = Vhx.connection.get('/me').body
      self.new(response_json)
    end

    def update(options)
      options = {id: self.id}.merge(options)
      Vhx.connection.put('/settings', options)
    end
  end
end
