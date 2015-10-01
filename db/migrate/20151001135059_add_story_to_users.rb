class AddStoryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :story, :text
  end
end
