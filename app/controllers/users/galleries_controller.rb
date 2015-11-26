class Users::GalleriesController < Users::UsersController
  before_action :authorize!

  def index
  end

  def new
    @gallery = Gallery.new
    @user = User.find_by(url: params[:user])
  end

  def create
    @user = User.find_by(url: params[:user])
    @gallery = Gallery.new(gallery_params)

    @gallery.user_id = current_user.id
    if @gallery.save
      current_user.gallery_id = @gallery.id
      current_user.save
      redirect_to dashboard_path(current_user.url)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(url: params[:user])
    @gallery = Gallery.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(url: params[:user])
    @gallery = Gallery.find_by(id: params[:id])
    @gallery.update_attributes(gallery_params)
    if @gallery.save
      redirect_to dashboard_path(current_user.url)
    else
      render :edit
    end
  end

  private

    def gallery_params
      params.require(:gallery).permit(:description, :image, :user_id)
    end
end
