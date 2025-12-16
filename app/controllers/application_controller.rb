class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  
  helper_method :current_user, :logged_in?, :cart_items_count
  
  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "You must be logged in to access this page"
    end
  end
  
  def current_cart_items
    if logged_in?
      current_user.cart_items
    else
      CartItem.where(session_id: session.id.to_s)
    end
  end
  
  def cart_items_count
    current_cart_items.sum(:quantity)
  end
end
