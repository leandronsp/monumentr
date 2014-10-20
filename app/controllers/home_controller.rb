class HomeController < ApplicationController
  def index
    if @current_user.authenticated?
      user = User.find(@current_user.id)
      @collections = user.collections

      render :dashboard
    end
  end
end
