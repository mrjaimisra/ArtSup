class Gallery < ActiveRecord::Base
  validates :description, presence: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "github_avatar.jpeg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
