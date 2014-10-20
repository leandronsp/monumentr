class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotUnique do
    flash.now[:error] = 'Account is taken'
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = 'User registered with success!'
      redirect_to root_path
    else
      flash.now[:error] = user.errors.full_messages.join(',')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
