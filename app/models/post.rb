class Post < ActiveRecord::Base
  validates :title, length: { minimum: 3 }
  has_attached_file :picture, 
                            styles: { medium:'400x400>'},
                            storage: :s3,
                            s3_credentials: {
                              bucket: 'dldb_makergram',
                              access_key_id: Rails.application.secrets.s3_public_key,
                              secret_access_key: Rails.application.secrets.s3_secret_key,
                            }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
  belongs_to :user
  has_many :likes
  has_and_belongs_to_many :tags

  def tag_names
    ''
  end

  def tag_names=(tag_names)
    return if tag_names.blank?

    tag_names.split(', ').uniq.each do |raw_tag|

      hash_tag = '#' + raw_tag.strip.delete('#')

      tag = Tag.find_or_create_by(name: hash_tag)
      self.tags << tag
    end
  end

  def liked?(user)
    return false if user.nil?
    likes.find_by(user: user)
  end

  def last_like(user)
    return likes.find_by(user: user) if likes.any?
    '0'
  end
end
