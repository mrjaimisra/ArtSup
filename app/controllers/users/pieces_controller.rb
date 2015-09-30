class Users::PiecesController < Users::UsersController
  def new
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

  private

  def piece_params
    params.require(:piece).permit(:name, :description, :collection_id, :image)
  end
end
