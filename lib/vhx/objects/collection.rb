module Vhx
  class Collection < VhxObject
    include Vhx::ApiOperations::Create
    include Vhx::ApiOperations::Update
    include Vhx::ApiOperations::Request
    include Vhx::ApiOperations::List
  end
end