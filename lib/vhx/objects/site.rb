module Vhx
  class Site < VhxObject
    include Vhx::ApiOperations::Create
    include Vhx::ApiOperations::Request
  end
end