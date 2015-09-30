class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
