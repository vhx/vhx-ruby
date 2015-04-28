module Vhx
  class VhxError < StandardError
    class TokenExpired < VhxError; end
    class UnauthorizedException < VhxError; end
    class ForbiddenException < VhxError; end
    class UnprocessableEntity < VhxError; end
    class PaymentRequiredError < VhxError; end
    class NotFoundError < VhxError; end
    class NotAcceptableError < VhxError; end
    class ServerError < VhxError; end
  end
end