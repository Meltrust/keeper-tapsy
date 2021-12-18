class api.v1::SessionsController < Api::ApiController
  acts_as_token_authentication_handler_for User, fallback: :exception, only: [:destroy]
  def create
    user = User.where(email: params[:email]).first

    if user&.valid_password?(params[:password])
      response.headers['X-User-email'] = user.email
      response.headers['X-User-token'] = user.authentication_token
      render plain: 'Signed in', status: :created
    else
      head(:unauthorized)
    end
  end

  def destroy
    user = User.where(email: request.headers['X-User-email']).first
    user.authentication_token = ''
    user.save
    response.headers['X-User-email'] = ''
    response.headers['X-User-token'] = ''
    render plain: 'Logged out', status: :created
  end
end
