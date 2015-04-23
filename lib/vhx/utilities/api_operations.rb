module Vhx
  module ApiOperations
    def find(resource)
      response_json = Vhx.connection.get(resource).body
      self.new(response_json)
    end

    def all(resource)
      response_json = Vhx.connection.get(resource).body
      response_json.map{ |obj| self.new(obj) }
    end

    def create(options)
      response = Vhx.connection.post do |req|
        req.url("/" + self.to_s.split("::").last.downcase.pluralize) #This url is based purely on VHX's API convention.
        req.body =  options
      end

      self.new(response.body)
    end

  end
end