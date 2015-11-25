class AddGiftToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gift, :string
  end
end
