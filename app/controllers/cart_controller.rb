class CartController < ApplicationController
  before_action :set_cart_items
  
  def index
    @cart_items = current_cart_items.includes(:product)
    @total = @cart_items.sum { |item| item.product.price * item.quantity }
  end

  def add_item
    product = Product.find(params[:product_id])
    
    cart_item = current_cart_items.find_or_initialize_by(product: product)
    cart_item.quantity ||= 0
    cart_item.quantity += (params[:quantity] || 1).to_i
    cart_item.user = current_user if logged_in?
    cart_item.session_id = session.id.to_s unless logged_in?
    
    if cart_item.save
      redirect_to cart_index_path, notice: "#{product.name} added to cart"
    else
      redirect_to product_path(product), alert: "Could not add to cart"
    end
  end

  def remove_item
    cart_item = current_cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_index_path, notice: "Item removed from cart"
  end

  def update_quantity
    cart_item = current_cart_items.find(params[:id])
    
    if params[:quantity].to_i > 0
      cart_item.update(quantity: params[:quantity])
      redirect_to cart_index_path, notice: "Quantity updated"
    else
      cart_item.destroy
      redirect_to cart_index_path, notice: "Item removed from cart"
    end
  end
  
  private
  
  def set_cart_items
    @cart_items = current_cart_items
  end
end
