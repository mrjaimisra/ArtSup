class Users::CollectionsController < Users::UsersController
  def new
    @collection = Collection.new
    @user = User.find(params[:user])
  end

  def create
    @user = User.find(params[:user])
    @collection = Collection.new(collection_params)
    @collection.user_id = current_user.id
    if @collection.save
      redirect_to dashboard_path
      flash.now[:notice] = "#{@collection.title} created"
    else
      render :new
    end
  end

  def show
    @collection = Collection.find(params[:id])
  end

  private

    def collection_params
      params.require(:collection).permit(:title, :description, :image, :image_filename)
    end
end
