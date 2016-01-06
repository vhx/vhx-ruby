module Vhx
  module ApiOperations
    module Update
      module InstanceMethods
        def update(payload)
          Vhx.connection.put(self.href, payload)
        end
      end

      def self.included(klass)
        klass.include(InstanceMethods)
      end
    end
  end
end