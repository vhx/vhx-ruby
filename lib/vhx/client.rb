require 'faraday'
require 'multi_json'
require 'json'
require 'oauth2'

module Vhx

  class Client
    attr_accessor :access_token

    BASE_URI = 'http://api.crystal.dev/'
    AUTHORIZE_URL = 'http://crystal.dev/oauth/authorize'
    TOKEN_URL     = 'http://crystal.dev/oauth/token'
    FIVE_MINUTES  = 300

    # Example of user_credentials
    # user_credentials = {
    #     :access_token => 'access_token',
    #     :refresh_token => 'refresh_token',
    #     :expires_at => Time.now + 1.day
    # }

    def initialize(client_id, client_secret, user_credentials, options={})
      client_opts = {
        :site          => options[:base_uri] || BASE_URI,
        :authorize_url => options[:authorize_url] || AUTHORIZE_URL,
        :token_url     => options[:token_url] || TOKEN_URL

        # In prod would also include ssl certs
        # :ssl           => {
        #                     :verify => true,
        #                     :cert_store => ::Coinbase::Client.whitelisted_cert_store
        #                   }

      }

      @oauth_client = OAuth2::Client.new(client_id, client_secret, client_opts)

      token_hash = user_credentials.dup
      token_hash[:access_token] ||= token_hash[:token]
      access_token = token_hash[:access_token]

      # # Fudge expiry to avoid race conditions
      # token_hash[:expires_in] = token_hash[:expires_in].to_i - FIVE_MINUTES if token_hash[:expires_in]
      # token_hash[:expires_at] = token_hash[:expires_at].to_i - FIVE_MINUTES if token_hash[:expires_at]

      token_hash.delete :expires
      raise "No access token provided" unless token_hash[:access_token]
      @oauth_token = OAuth2::AccessToken.from_hash(@oauth_client, token_hash)
    end

    def refresh!
      raise "Access token not initialized." unless @oauth_token
      @oauth_token = @oauth_token.refresh!
    end

    def oauth_token
      raise "Access token not initialized." unless @oauth_token
      refresh! if @oauth_token.expired?
      @oauth_token
    end

    def credentials
      @oauth_token.to_hash
    end

    def packages_on_sale
      unless @packages
        me = get('/me')

        @packages = []

        if me['_embedded']['sites'][0]
          me['_embedded']['sites'].each do |s|
            site      = get(s['_links']['self']['href'])
            @packages = @packages + site['_embedded']['packages']
          end
        end
      end

      return @packages || []
    end

    def create_ticket(payload)
      @ticket = post('/tickets', payload)
    end

    def get(url, options = {})
      request :get, url, options
    end

    def post(url, options = {})
      request :post, url, options
    end

    def request(method, path, data, options={})
      @last_response = response = connection.send(method, URI.encode(path.to_s), data, options)
      JSON.parse(response.body)
    end

    def connection
      @connection ||= Faraday.new(url: 'http://api.crystal.dev') do |conn|
        conn.request :url_encoded
        conn.adapter Faraday.default_adapter
        conn.headers[:Authorization]  = "Bearer #{@oauth_token.token}"
      end
      @connection
    end

  end
end
