class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  scope :in_progress, ->{where("orders.status = 0")}
  scope :complete, -> {where("orders.status = 1")}

  COMPLETE = "complete"
  IN_PROGRESS = "in_progress"

  validates_numericality_of :quantity, :status

  def self.find_with_product(product)
    return [] unless product
    Order.joins(:user).
        where(["orders.product_id = ?", product.id]).order("orders.created_at DESC")
  end

  def state
    status == 0 ? IN_PROGRESS : COMPLETE
  end

end