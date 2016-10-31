module Vhx
  class Analytics < VhxObject
    def self.report(query_params = {})
      response = Vhx.connection.get("/analytics", query_params)

      self.new(response.body)
    end
  end
end
