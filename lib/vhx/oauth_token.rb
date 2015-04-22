class OAuthToken < Struct.new(:access_token, :refresh_token, :expires_at, :expires_in, :refreshed)
  def initialize(params = {})
    self.access_token  = params[:access_token]
    self.refresh_token = params[:refresh_token]
    self.expires_at    = params[:expires_at] || Time.now + params[:expires_in]
    self.expires_in    = params[:expires_in]
  end
end
