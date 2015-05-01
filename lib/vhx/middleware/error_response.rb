module Vhx
  module Middleware
    class ErrorResponse < Faraday::Response::Middleware
      def on_complete(env)
        error_class = case env[:status]
        when 200, 204
        when 304
        when 400
          BadRequestError
        when 401
          if env[:body].fetch('message', '').match(/token/)
            InvalidTokenError
          else
            UnauthorizedError
          end
        when 402
          PaymentRequiredError
        when 404
          NotFoundError
        when 406
          NotAcceptableError
        else
          ServerError
        end

        if error_class
          raise error_class.new(env[:body], env[:status], env[:url])
        end
      end
    end
  end
end
