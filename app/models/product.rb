class Product < ActiveRecord::Base
  belongs_to :store
  mount_uploader :image, ImageUploader
end
