class ManageController < ApplicationController
  before_action :check_authorization
  before_action :check_ownership, only: [:edit, :update]

  def check_authorization
    unless @current_user.authenticated?
      redirect_to sign_in_path
    end
  end

  def check_ownership
    fail 'Subclass MUST implement this'
  end
end
