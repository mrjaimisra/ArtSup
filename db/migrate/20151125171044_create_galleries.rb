class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
