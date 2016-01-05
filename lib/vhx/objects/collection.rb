module Vhx
  class Collection < VhxObject
    include Vhx::ApiOperations::Request
    include Vhx::ApiOperations::List
  end
end