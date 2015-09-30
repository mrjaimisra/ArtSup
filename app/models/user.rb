class User < ActiveRecord::Base
  has_many :collections

  def self.find_or_create_from_auth_hash(data)
    user = User.find_or_create_by(provider: data.provider, uid: data.uid)
    user.email      = data.info.email
    user.name       = data.info.name
    user.image_url  = data.info.image
    user.token      = data.credentials.token
    user.save

    user
  end
end
