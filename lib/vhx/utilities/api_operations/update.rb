module Vhx
  module ApiOperations
    module Update
      module InstanceMethods
        def update(identifier, payload)
          Vhx.connection.put(get_hypermedia(identifier), payload)
        end
      end

      def self.included(klass)
        klass.include(InstanceMethods)
      end
    end
  end
end