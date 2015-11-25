class User < ActiveRecord::Base
  has_many :artist_to_supporters_i_am_the_artist   , foreign_key: :artist_id,    class_name: 'ArtistToSupporter'
  has_many :artist_to_supporters_i_am_the_supporter, foreign_key: :supporter_id, class_name: 'ArtistToSupporter'

  has_many :supporters,        through: :artist_to_supporters_i_am_the_artist
  has_many :supported_artists, through: :artist_to_supporters_i_am_the_supporter, source: :artist

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "github_avatar.jpeg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def self.find_or_create_from_auth_hash(data)
    user = User.find_or_create_by(provider: data.provider, uid: data.uid)
    user.email      = data.info.email
    user.name       = data.info.name
    user.zip_code   = data.extra.postal_code
    user.token      = data.credentials.token
    user.save

    user
  end

  before_validation :generate_url

  def generate_url
    if name
      self.url = name.parameterize
    else
      self.url = "hello"
    end
  end
end
