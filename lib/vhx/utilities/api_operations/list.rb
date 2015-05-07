require_relative '../vhx_collection'

module Vhx
  module ApiOperations
    module List
      module ClassMethods
        def all(payload)
          response = Vhx.connection.get do |req|
            req.url '/' + get_klass.downcase + 's'
            req.body = payload
          end
          VhxCollection.new(response.body, get_klass.downcase + 's')
        end
      end

      def self.included(klass)
        klass.extend(ClassMethods)
      end
    end
  end
end
