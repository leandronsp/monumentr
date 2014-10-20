class SessionsController < ApplicationController
  def create
    user = User.authenticate!(*user_params.values_at(:email, :password))
    if user
      session[:user_id] = user.id
      flash[:success] = 'Sign in successfully!'
      redirect_to root_path
    else
      flash.now[:error] = 'Email/Password invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
