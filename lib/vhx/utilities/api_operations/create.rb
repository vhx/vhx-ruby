module Vhx
  module ApiOperations
    module Create
      module ClassMethods
        def create(payload)
          klass = get_klass
          response = Vhx.connection.post do |req|
            req.url('/' + klass.downcase.pluralize) #This url is based purely on VHX's API convention.
            req.body = payload
          end

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
