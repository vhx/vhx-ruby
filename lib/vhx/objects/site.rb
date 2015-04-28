module Vhx
  class Site < VhxObject

    def add_follower(identifier)
      response = Vhx.connection.put do |req|
        req.url('/sites/' + self.id.to_s + '/followers')
        req.body = get_hypermedia(identifier)
      end
    end

    def remove_follower(identifier)
      response = Vhx.connection.delete do |req|
        req.url('/sites/' + self.id.to_s + '/followers')
        req.body = get_hypermedia(identifier)
      end
    end

  end
end