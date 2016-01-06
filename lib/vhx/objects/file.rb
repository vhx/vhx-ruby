module Vhx
  class File < VhxObject
    def self.all(payload)
      response = Vhx.connection.get do |req|
        req.url payload[:video].match(/\/videos.*/)[0] + '/files'
        req.body = payload
      end
      VhxListObject.new(response.body, 'files')
    end
  end
end