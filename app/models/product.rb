class Product < ApplicationRecord
  belongs_to :category
  
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  
  def in_stock?
    stock_quantity > 0
  end
end
