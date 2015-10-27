require 'faraday'
require 'faraday_middleware'

require "vhx/version"
require "vhx/error"
require "vhx/oauth_token"

require 'vhx/middleware/error_response'
require 'vhx/middleware/oauth2'

require "vhx/client"

require "vhx/utilities/vhx_helper"
require "vhx/utilities/api_operations/create"
require "vhx/utilities/api_operations/delete"
require "vhx/utilities/api_operations/list"
require "vhx/utilities/api_operations/request"

require "vhx/utilities/vhx_object"
require "vhx/utilities/vhx_list_object"

require "vhx/objects/user"
require "vhx/objects/package"
require "vhx/objects/site"
require "vhx/objects/file"
require "vhx/objects/video"
require "vhx/objects/customer"
require "vhx/objects/subscription"

module Vhx
  class << self
    def setup(options = {})
      options[:client_id]         ||= @client_id
      options[:client_secret]     ||= @client_secret
      options[:skip_auto_refresh]   = @skip_auto_refresh if options[:skip_auto_refresh].nil?
      Vhx.client = Vhx::Client.new(options)
    end

    def config(config = {})
      @client_id          = config[:client_id]
      @client_secret      = config[:client_secret]
      @skip_auto_refresh  = config[:skip_auto_refresh] || false
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