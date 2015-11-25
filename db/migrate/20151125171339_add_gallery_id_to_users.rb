class AddGalleryIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gallery_id, :integer
  end
end
