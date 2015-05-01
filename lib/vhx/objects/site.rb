module Vhx
  class Site < VhxObject
    include Vhx::ApiOperations::Create
    include Vhx::ApiOperations::Request

    def add_follower(identifier)
      if identifier.match(/@/)
        body = {user: {email: identifier}}
      else
        body = {user: get_hypermedia(identifier, 'User')}
      end

      response = Vhx.connection.put do |req|
        req.url('/sites/' + self.id.to_s + '/followers')
        req.body = body
      end
    end

    def remove_follower(identifier)
      response = Vhx.connection.delete do |req|
        req.url('/sites/' + self.id.to_s + '/followers')
        # req.body = {user: get_hypermedia(identifier, 'User')} #only current_user can be removed.
      end
    end

  end
end