module Vhx
  class User < VhxObject
    include Vhx::ApiOperations::Request

    def self.me
      response_json = Vhx.connection.get('/me').body
      self.new(response_json)
    end

    def update(options)
      options = {id: self.id}.merge(options)
      Vhx.connection.put('/settings', options)
    end

    def selling_packages
      return @selling_packages if @selling_packages

      @selling_packages = []
      @obj_hash['_embedded']['sites'].each do |site|
        site = Vhx.connection.get(site['_links']['self']['href']).body
        @selling_packages += site['_embedded']['packages']
      end

      @selling_packages = build_association(@selling_packages, 'packages')
    end

  end
end
