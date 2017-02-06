module Vhx
  module ApiOperations
    module Update
      module InstanceMethods
        def update(payload, headers = {})
          Vhx.connection.put(self.href, payload, headers)
        end
      end

      def self.included(klass)
        klass.include(InstanceMethods)
      end
    end
  end
end
