class ArtistToSupporter < ActiveRecord::Base
  self.table_name = :artists_to_supporters
  belongs_to :artist,    class_name: 'User'
  belongs_to :supporter, class_name: 'User'
end
