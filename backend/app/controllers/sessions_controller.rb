class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash!(request.env["omniauth.auth"])
    session[:user_id] = user.id

    redirect_to "#{ENV.fetch('FRONTEND_URL', 'http://localhost:3000')}"
  end

  def destroy
    reset_session
    redirect_to "#{ENV.fetch('FRONTEND_URL', 'http://localhost:3000')}"
  end

  def show
    if current_user
      render json: { logged_in: true, user: current_user }
    else
      render json: { logged_in: false }
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
