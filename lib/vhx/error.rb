module Vhx
  class VhxError < StandardError
    attr_reader :response_body, :response_status, :url, :message

    def initialize(response_body, response_status, url)
      @response_body   = response_body
      @response_status = response_status
      @url             = url
      @message         = response_body.is_a?(Hash) ? response_body['message'] : response_body.to_s

      super(@message)
    end

  end

  class BadRequestError < VhxError; end
  class UnauthorizedError < VhxError; end
  class InvalidTokenError < VhxError; end
  class PaymentRequiredError < VhxError; end
  class NotFoundError < VhxError; end
  class NotAcceptableError < VhxError; end
  class ServerError < VhxError; end
end