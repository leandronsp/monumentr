class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :build_current_user

  private

  def build_current_user
    return build_unauthenticated_current_user unless session[:user_id]

    user = User.find_by_id(session[:user_id])
    return build_unauthenticated_current_user unless user

    build_authenticated_current_user(user)
  end

  def build_authenticated_current_user(user)
    @current_user = OpenStruct.new({
      id: user.id,
      name: user.name,
      authenticated?: true
    })
  end

  def build_unauthenticated_current_user
    @current_user = OpenStruct.new({
      id: nil,
      name: nil,
      authenticated?: false
    })
  end
end
