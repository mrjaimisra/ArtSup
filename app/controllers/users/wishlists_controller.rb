class Users::WishlistsController < Users::UsersController
  before_filter :set_user, except: :index

  def index
  end

  def new
    @wishlist = get_wishlist(params[:id])
  end

  def create
    wishlist_id = parse_url_for_wishlist_id(params[:wishlist_url])
    current_user.wishlist_id = wishlist_id
    current_user.save
    get_wishlist(wishlist_id)

    redirect_to users_wishlist_path(user: @user.id,
                                    id: wishlist_id)
  end

  def show
    @wishlist = get_wishlist(params[:id])
  end

  def update
    Rails.cache.clear
    get_wishlist(params[:id])

    redirect_to users_wishlist_path(user: @user.id,
                                    id: params[:id])
  end

  def destroy
    Rails.cache.clear

    @user.wishlist_id = nil
    @user.save

    redirect_to new_users_wishlist_path(@user)
  end

  private
    def set_user
      @user ||= User.find_by(id: params[:user])
    end

    def get_wishlist(id)
      cache_store.fetch "wishlist_#{id}", expires_in: 1.hour do
        Wishlist.fetch(id)
      end
    end

    def parse_url_for_wishlist_id(url)
      url.split("/").last
    end
end
