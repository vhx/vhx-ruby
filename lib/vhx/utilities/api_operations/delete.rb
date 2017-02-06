module Vhx
  module ApiOperations
    module Delete
      module ClassMethods
        def delete(identifier, payload = {}, headers = {})
          Vhx.connection.delete(
            get_hypermedia(identifier),
            payload,
            headers,
          )
        end
      end

      def self.included(klass)
        klass.extend(Vhx::HelperMethods)
        klass.extend(ClassMethods)
      end
    end
  end
end
