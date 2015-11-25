class CreateArtistsToSupporters < ActiveRecord::Migration
  def change
    create_table :artists_to_supporters do |t|
      t.integer :artist_id
      t.integer :supporter_id
    end
  end
end
