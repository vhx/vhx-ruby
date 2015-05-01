module Vhx
  module ApiOperations
    module Request
      module ClassMethods
        def find(identifier)
          response = Vhx.connection.get(get_hypermedia(identifier))
          self.new(response.body)
        end
      end

      def self.included(klass)
        klass.extend(Vhx::HelperMethods)
        klass.extend(ClassMethods)
      end
    end
  end
end
