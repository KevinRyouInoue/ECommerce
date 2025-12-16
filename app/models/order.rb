class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  
  validates :status, presence: true, inclusion: { in: %w[pending processing shipped delivered cancelled] }
  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :shipping_address, presence: true
  
  before_validation :set_default_status, on: :create
  
  private
  
  def set_default_status
    self.status ||= 'pending'
  end
end
