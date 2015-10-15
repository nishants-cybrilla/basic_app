class Product < ActiveRecord::Base
  belongs_to :store
  mount_uploader :image, ImageUploader
  attr_accessor :image_width, :image_height

  validate :check_avatar_dimensions
  validate :image_size_validation, :if => "image?"

  def image_size_validation
    if image.size > 1.megabytes
      errors.add(:base, "Image should be less than 1MB")
    end
  end

  def check_avatar_dimensions
    if !image_cache.nil? && (image.width < 300 || image.height < 300)
      errors.add :image, "Dimension too small"
    end
  end
end
