class OrdersController < ApplicationController
  before_action :require_login
  
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def new
    @cart_items = current_cart_items.includes(:product)
    
    if @cart_items.empty?
      redirect_to cart_index_path, alert: "Your cart is empty"
      return
    end
    
    @order = Order.new
    @total = @cart_items.sum { |item| item.product.price * item.quantity }
  end

  def create
    @cart_items = current_cart_items.includes(:product)
    
    if @cart_items.empty?
      redirect_to cart_index_path, alert: "Your cart is empty"
      return
    end
    
    total = @cart_items.sum { |item| item.product.price * item.quantity }
    
    @order = current_user.orders.build(
      total_amount: total,
      shipping_address: order_params[:shipping_address]
    )
    
    if @order.save
      # Create order items
      @cart_items.each do |cart_item|
        @order.order_items.create!(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
        
        # Update product stock
        product = cart_item.product
        product.update(stock_quantity: product.stock_quantity - cart_item.quantity)
      end
      
      # Clear cart
      @cart_items.destroy_all
      
      redirect_to order_path(@order), notice: "Order placed successfully!"
    else
      @total = total
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
  
  private
  
  def order_params
    params.require(:order).permit(:shipping_address)
  end
end
