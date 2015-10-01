class RemoveDescriptionFromPieces < ActiveRecord::Migration
  def change
    remove_column :pieces, :description, :string
  end
end
