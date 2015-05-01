module Vhx
  module ApiOperations
    module Delete
      module InstanceMethods
        def delete(identifier)
          Vhx.connection.delete(get_hypermedia(identifier))
        end
      end

      def self.included(klass)
        klass.include(InstanceMethods)
      end
    end
  end
end