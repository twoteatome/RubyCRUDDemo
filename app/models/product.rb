class Product < ApplicationRecord
  has_many :order
  belongs_to :user

  validates_numericality_of :price
  validates :name, presence: true
  validates :price, presence: true
  validates :short_description, presence: true

  def self.find_with_user(user)
    return [] unless user
    Product.where(["products.user_id = ?", user.id]).order("products.created_at DESC")
  end
end
