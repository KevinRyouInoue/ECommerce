class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      
      # Transfer cart items from session to user
      CartItem.where(session_id: session.id.to_s, user_id: nil).update_all(user_id: @user.id, session_id: nil)
      
      redirect_to root_path, notice: "Account created successfully"
    else
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
