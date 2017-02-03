require_relative '../vhx_list_object'

module Vhx
  module ApiOperations
    module List
      module ClassMethods
        def all(payload = {}, headers = {})
          response = Vhx.connection.get(
            '/' + get_klass.downcase + 's',
            payload,
            headers,
          )
          VhxListObject.new(response.body, get_klass.downcase + 's')
        end

        def list(payload = {}, headers = {})
          self.all(payload, headers)
        end
      end

      def self.included(klass)
        klass.extend(ClassMethods)
      end
    end
  end
end
