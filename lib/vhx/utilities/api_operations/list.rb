module Vhx
  module ApiOperations
    module List
      module ClassMethods
        def all(resource)
          response_json = Vhx.connection.get(resource).body
          response_json.map{ |obj| self.new(obj) }
        end
      end

      def self.included(klass)
        klass.extend(ClassMethods)
      end
    end
  end
end
