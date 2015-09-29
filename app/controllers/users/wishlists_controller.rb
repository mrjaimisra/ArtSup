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

    redirect_to users_wishlist_path(user: @user.id, id: wishlist_id)
  end

  def show
    @wishlist = Wishlist.fetch(params[:id])
    @user = User.find_by(id: params[:user])
  end
end
