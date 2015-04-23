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

  end
end