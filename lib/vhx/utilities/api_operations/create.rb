module Vhx
  module ApiOperations
    module Create
      module ClassMethods
        def create(payload, headers = {})
          klass = get_klass
          response = Vhx.connection.post do |req|
            req.url('/' + klass.downcase + 's') # This url is based purely on VHX's API convention.

            if headers.length > 0
              headers.each do |key, value|
                req.headers[key] = value
              end
            end

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
