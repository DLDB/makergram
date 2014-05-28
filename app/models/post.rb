class Post < ActiveRecord::Base
  validates :title, length: { minimum: 3 }
  has_attached_file :picture, styles: { medium:'300x300>'}
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
end
