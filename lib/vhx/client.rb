module Vhx

  class Client
    attr_reader :client_id, :client_secret, :api_base_url, :oauth_token, :api_key

    def initialize(client_id, client_secret, options = {})
      @api_base_url  = 'http://api.crystal.dev'
      @client_id     = options[:client_id]
      @client_secret = options[:client_secret]
      @oauth_token   = OAuthToken.new(options[:oauth_token])
      @api_key       = options[:api_key]
      @headers       = {}

      configure_connection
    end

    def configure_connection
      @conn = Faraday::Connection.new(url: api_base_url, headers: configured_headers) do |faraday|
        faraday.request :url_encoded
        faraday.request :json
        faraday.response :json
        faraday.response :logger

        faraday.adapter Faraday.default_adapter
      end

      @conn
    end

    def configured_headers
      if access_token
        @headers[:Authorization] = "Bearer #{access_token}"
      elsif api_key
        @headers[:Authorization] = Faraday::Request::BasicAuthentication.header(api_key, '')
      end

      @headers
    end

    def access_token
      oauth_token.access_token
    end

    def refresh_access_token
      conn = @connection.dup
      conn.headers.delete(:Authorization)
      response = conn.post do |req|
        req.url '/oauth/token'
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = {
          grant_type:    'refresh_token',
          refresh_token: oauth_token.refresh_token,
          client_id:     client_id,
          client_secret: client_secret
        }
      end

      @oauth_token = OAuthToken.new(response.body)

      configure_connection
    end

  end
end
