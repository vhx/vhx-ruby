module Vhx
  module ApiOperations
    def self.included(klass)
      klass.extend(ClassMethods)
      klass.extend(HelperMethods)
      klass.include(HelperMethods)
    end

    module ClassMethods
      def find(identifier)
        response = Vhx.connection.get(get_hypermedia(identifier))
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
    end

    module HelperMethods
      def get_klass
        self.to_s.split("::").last
      end

      def get_hypermedia(identifier)
        if identifier.class.to_s.match(/Integer|Fixnum/)
          klass = get_klass
          return '/' + klass.downcase.pluralize + '/' + identifier.to_s #This url is based purely on VHX's API convention (not nested).
        end

        identifier
      end
    end
  end
end