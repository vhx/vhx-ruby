class OAuthToken < Struct.new(:access_token, :refresh_token, :expires_at, :expires_in, :expires, :refreshed)
  def initialize(params = {}, refreshed = false)
    params             = Hash[params.map{ |k, v| [k.to_sym, v] }]
    self.access_token  = params[:access_token]
    self.refresh_token = params[:refresh_token]
    self.expires_at    = params[:expires_at] || Time.now.to_i + params[:expires_in].to_i
    self.expires_in    = params[:expires_in]
    self.expires       = (params[:expires_at] || params[:expires_in]) ? true : false
    self.refreshed     = refreshed
  end
end
