class Users::CollectionsController < Users::UsersController
  def index
    @collections = Collection.where(user_id: current_user.id)
    @user = User.find_by(id: params[:user])
  end

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

  def edit
    @user = User.find_by(id: params[:user])
    @collection = Collection.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:user])
    @piece = Piece.find_by(id: params[:id])
    @collection = Collection.find_by(id: @piece.collection_id)
    @collection.update_attributes(collection_params)
    if @collection.save
      redirect_to users_collections_path(user: params[:user])
    else
      render :edit
    end
  end

  def show
    @user = User.find_by(id: params[:user])
    @piece = Piece.find_by(id: params[:id])
    @collection = Collection.find_by(id: @piece.id)
    @pieces = @collection.pieces
  end

  def destroy
    @collection = Collection.find_by(id: params[:id])
    @collection.destroy

    redirect_to users_collections_path(user: params[:user])
  end

  private

    def collection_params
      params.require(:collection).permit(:title, :description, :image)
    end
end
