module Vhx
  class VhxError < StandardError
    class TokenExpired < VhxError; end
  end
end