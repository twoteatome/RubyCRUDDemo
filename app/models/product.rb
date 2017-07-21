class Product < ApplicationRecord
  has_many :order
  belongs_to :user

  validates_numericality_of :price
  validates :name, presence: true
  validates :price, presence: true
  validates :short_description, presence: true
end
