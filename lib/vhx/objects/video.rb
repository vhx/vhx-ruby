module Vhx
  class Video < VhxObject
    include Vhx::ApiOperations::Create
    include Vhx::ApiOperations::Update
    include Vhx::ApiOperations::Request
    include Vhx::ApiOperations::List

    def files(payload = {})
      fetch_linked_association(@obj_hash, "files", payload)
    end
  end
end