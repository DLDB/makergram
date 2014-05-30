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

end
