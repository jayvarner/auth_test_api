class TokenController < ActionController::API
  def show
    login = Login.find_by(token: params[:token])
    if login
      # Trigger refresh of token by saving.
      login.save
      render json: login.user
    else
      render json: {
        status: 401,
        message: 'The current login is invalid. Please try logging in again.'
      }
  end
end
