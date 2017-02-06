module Vhx
  module ApiOperations
    module Request
      module ClassMethods
        def find(identifier, payload = {}, headers = {})
          response = Vhx.connection.get(
            get_hypermedia(identifier),
            payload,
            headers,
          )
          self.new(response.body)
        end

        def retrieve(identifier, payload = {}, headers = {})
          self.find(identifier, payload, headers)
        end
      end

      def self.included(klass)
        klass.extend(Vhx::HelperMethods)
        klass.extend(ClassMethods)
      end
    end
  end
end
