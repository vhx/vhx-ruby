module Vhx
  class Item < VhxObject
    def self.all(payload)
      response = Vhx.connection.get do |req|
        req.url payload[:collection].match(/\/collections.*/)[0] + '/items'
        req.body = payload
      end
      VhxListObject.new(response.body, 'items')
    end
  end
end