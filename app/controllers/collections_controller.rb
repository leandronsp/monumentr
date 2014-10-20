class CollectionsController < ApplicationController

  before_filter :check_authorization

  def create
    @collection = Collection.new(collection_params.merge(user_id: @current_user.id))

    if @collection.save
      flash[:success] = 'Album created!'
      redirect_to edit_collection_path(@collection.id)
    else
      flash.now[:error] = @collection.errors.full_messages.join(',')
      render :new
    end
  end

  private

  def collection_params
    params.require(:collection).permit([
      :name, :description, :user_id, { monuments_attributes: [ :name ] }
    ])
  end

  def check_authorization
    unless @current_user.authenticated?
      redirect_to sign_in_path
    end
  end
end
