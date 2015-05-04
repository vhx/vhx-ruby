module Vhx
  class Site < VhxObject
    include Vhx::ApiOperations::Create
    include Vhx::ApiOperations::Request

    def add_follower(identifier)
      if identifier.class.to_s == 'String' && identifier.match(/@/)
        body = {user: {email: identifier}}
      else
        body = {user: get_hypermedia(identifier, 'User')}
      end

      response = Vhx.connection.put do |req|
        req.url('/sites/' + self.id.to_s + '/followers')
        req.body = body
      end

      self
    end

    def remove_follower
      response = Vhx.connection.delete do |req|
        req.url('/sites/' + self.id.to_s + '/followers')
      end

      self
    end

  end
end