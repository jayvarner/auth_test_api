require 'digest/sha1'

class SessionsController < ApplicationController
  def create
    # @Login = .find_or_create_from_auth_hash(auth_hash)
    # self.current_user = @user
    Rails.logger.debug "OmniauthCallbacksController#shibboleth: request.env['omniauth.auth']: #{auth_hash.inspect}"
    case auth_hash[:provider]
    when 'shibboleth'
      @login = Login.find_or_create_by(
        provider: auth_hash[:provider],
        email: auth_hash[:info][:email],
        uid: Digest::SHA1.hexdigest(auth_hash[:uid].to_s)
      )
      end
      oauth_response = {
        access_token: @login.access_token,
        token_type: 'bearer',
        expires_in: 3600
      }
      response.headers['Cache-Control'] = 'no-store'
      response.headers['Pragma'] = 'no-cache'
      # @login.expires_in = 3600

    #render json: @login
    redirect_to generate_url('http://localhost:4200/torii/redirect.html', oauth_response.as_json)
  end

  protected

  def auth_hash
    request.env['omniauth.auth'].symbolize_keys!
  end

  def generate_url(url, params = {})
    uri = URI(url)
    uri.query = params.to_query
    uri.to_s
  end
end
