class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:format])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    current_user.update_attributes(user_params)
    if current_user.save
      redirect_to profile_path(user: params[:user])
    else
      render :edit
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :zipcode, :provider, :token, :uid, :image_url, :wishlist_id, :story, :avatar)
    end
end
