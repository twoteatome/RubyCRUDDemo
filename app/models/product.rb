class Product < ApplicationRecord
  has_many :order
  belongs_to :user

  mount_uploader :image, ImageUploader
  validates_numericality_of :price
  validates :name, presence: true
  validates :price, presence: true
  validates :short_description, presence: true
  validates :image, presence: true
  validates_processing_of :image
  validate :image_size_validation

  private
    def image_size_validation
      errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
    end
end