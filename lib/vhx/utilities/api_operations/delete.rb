module Vhx
  module ApiOperations
    module Delete
      module ClassMethods
        def delete(identifier, payload = {})
          Vhx.connection.delete(get_hypermedia(identifier), payload)
        end
      end

      def self.included(klass)
        klass.extend(Vhx::HelperMethods)
        klass.extend(ClassMethods)
      end
    end
  end
end