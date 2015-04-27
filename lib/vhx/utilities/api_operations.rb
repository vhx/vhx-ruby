module Vhx
  module ApiOperations
    def find(identifier)
      klass = get_klass

      if identifier.class.to_s == 'String'
        hypermedia = identifier
      elsif identifier.class.to_s.match(/Integer|Fixnum/)
        hypermedia = '/' + klass.downcase.pluralize + '/' + identifier.to_s #This url is based purely on VHX's API convention (not nested).
      end

      response = Vhx.connection.get(hypermedia)
      self.new(response.body)
    end

    def all(resource)
      response_json = Vhx.connection.get(resource).body
      response_json.map{ |obj| self.new(obj) }
    end

    def create(options)
      klass = get_klass

      unless ['Site', 'Ticket', 'Package', 'Video'].include?(klass)
        raise Error
      end

      response = Vhx.connection.post do |req|
        req.url('/' + klass.downcase.pluralize) #This url is based purely on VHX's API convention.
        req.body = options
      end

      self.new(response.body)
    end

protected

    def get_klass
      self.to_s.split("::").last
    end

  end
end