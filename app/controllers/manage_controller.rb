class ManageController < ApplicationController
  before_filter :check_authorization
  before_filter :check_ownership, only: [:edit, :update]

  def check_authorization
    unless @current_user.authenticated?
      redirect_to sign_in_path
    end
  end

  def check_ownership
   # TODO: to be implemented
  end
end
