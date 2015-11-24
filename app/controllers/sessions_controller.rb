class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(auth_hash)

    if user
      session[:user_id] = user.id
      redirect_to dashboard_path(user.url)
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
