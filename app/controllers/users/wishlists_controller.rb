class Users::WishlistsController < Users::UsersController
  def index
  end

  def new
    @user = User.find_by(id: params[:user])
    @wishlist = Wishlist.fetch(params[:id])
  end

  def create
    wishlist_id = params[:wishlist_url].split("/").last
    @user = User.find_by(id: params[:user])
    @user.wishlist_id = wishlist_id
    @user.save

    redirect_to users_wishlist_path(user: @user.id, id: wishlist_id)
  end

  def show
    @user = User.find_by(id: params[:user])
    @wishlist = Wishlist.fetch(params[:id])
  end

  def destroy
    @user = User.find_by(id: params[:user])
    @user.wishlist_id = nil
    @user.save

    redirect_to new_users_wishlist_path(@user)
  end
end
