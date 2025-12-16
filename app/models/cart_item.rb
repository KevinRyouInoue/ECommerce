class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :user, optional: true
  
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :product_id, uniqueness: { scope: [:user_id, :session_id], message: "already in cart" }
  
  def total_price
    product.price * quantity
  end
end
