module Vhx
  class User
    def self.me
      Vhx.connection.get('/me')
    end
  end
end
