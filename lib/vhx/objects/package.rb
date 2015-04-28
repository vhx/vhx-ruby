module Vhx
  class Package < VhxObject

    def add_video(identifier)
      response = Vhx.connection.put do |req|
        req.url('/packages/' + self.id.to_s + '/videos')
        req.body = get_hypermedia(identifier)
      end
    end

    def remove_video(identifier)
      response = Vhx.connection.delete do |req|
        req.url('/packages/' + self.id.to_s + '/videos')
        req.body = get_hypermedia(identifier)
      end
    end

  end
end