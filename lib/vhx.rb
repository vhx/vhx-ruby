require 'faraday'
require 'faraday_middleware'

require "vhx/version"
require "vhx/error"
require "vhx/oauth_token"

# require 'vhx/middleware/error_response'
# require 'vhx/middleware/oauth2'

require "vhx/client"

require "vhx/utilities/api_operations"
require "vhx/utilities/vhx_object"
require "vhx/utilities/vhx_collection"

require "vhx/objects/user"
require "vhx/objects/package"
require "vhx/objects/site"
require "vhx/objects/follower"
require "vhx/objects/file"
require "vhx/objects/ticket"
require "vhx/objects/video"

module Vhx
  class << self
    def setup(credentials = {})
      Vhx.client = Vhx::Client.new(credentials)
    end

    def client
      @client
    end

    def client=(new_client)
      @client = new_client
    end

    def connection
      client ? client.connection : nil
    end
  end
end