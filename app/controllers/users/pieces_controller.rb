class Users::PiecesController < Users::UsersController
  def new
    @user = User.find_by(id: params[:user])
    @collection = Collection.find_by(id: params[:collection_id])
    @piece = Piece.new
  end

  def create
    @collection = Collection.find_by(id: params[:collection_id])
    @piece = Piece.create(piece_params)
    @piece.collection_id = @collection.id
    if @piece.save
      redirect_to dashboard_path
      flash.now[:notice] = "#{@piece.name} created"
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:user])
    @collection = Collection.find_by(id: params[:collection_id])
    @piece = Piece.find_by(id: params[:id])
  end

  def update
    @collection = Collection.find_by(id: params[:collection_id])
    @piece = Piece.find_by(id: params[:id])
    @piece.update_attributes(piece_params)
    if @piece.save
      redirect_to users_collection_path(user: params[:user], id: @collection.id)
    else
      render :edit
    end
  end

  def destroy
    @piece = Piece.find_by(id: params[:id])
    @collection = Collection.find_by(id: @piece.collection_id)
    @user = User.find_by(id: params[:user])

    @piece.destroy

    redirect_to users_collection_path(id: params[:id], user: @user.id)
  end

  private

  def piece_params
    params.require(:piece).permit(:name, :collection_id, :image)
  end
end
