class Piece < ActiveRecord::Base
  belongs_to :collection

  has_attached_file :image,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    bucket: "artsup"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
