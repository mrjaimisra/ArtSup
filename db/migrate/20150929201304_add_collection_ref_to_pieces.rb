class AddCollectionRefToPieces < ActiveRecord::Migration
  def change
    add_reference :pieces, :collection, index: true, foreign_key: true
  end
end
