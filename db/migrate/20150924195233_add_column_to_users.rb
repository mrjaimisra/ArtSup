class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wishlist_id, :string
  end
end
