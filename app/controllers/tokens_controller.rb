class TokensController < ActionController::API
  def index
    login = Login.find_by(access_token: params[:access_token])
    login.save
    render json: login, include: ['user']
  end

  def show
    login = Login.find_by(access_token: params[:access_token])
    if login
      # Trigger refresh of token by saving.
      login.save
      response.headers['Cache-Control'] = 'no-store'
      response.headers['Pragma'] = 'no-cache'
      login.expires_in = 3600
      render json: login.user
    else
      render json: {
        status: 401,
        message: 'The current login is invalid. Please try logging in again.'
      }
    end
  end
end
