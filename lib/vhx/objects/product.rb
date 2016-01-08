module Vhx
  class Product < VhxObject
    include Vhx::ApiOperations::Request
    include Vhx::ApiOperations::List
  end
end