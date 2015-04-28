module Vhx
  module Middleware
    class ErrorResponse < Faraday::Response::Middleware
      def on_complete(env)
        error_class = case env[:status]
        when 200, 204
        when 304
        when 402
          Vhx::VhxError::PaymentRequiredError
        when 404
          Vhx::VhxError::NotFoundError
        when 406
          Vhx::VhxError::NotAcceptableError
        else
          Vhx::VhxError::ServerError
        end

        if error_class
          raise error_class.new
        end
      end
    end
  end
end
