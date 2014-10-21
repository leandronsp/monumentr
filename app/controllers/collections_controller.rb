class CollectionsController < ManageController

  def edit
    @collection = Collection.find(params[:id])
  end

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

  def update
    @collection = Collection.find(params[:id])

    if @collection.update_attributes(collection_params)
      flash[:success] = 'Album Updated!'
      redirect_to edit_collection_path(@collection.id)
    else
      flash.now[:error] = @collection.errors.full_messages.join(',')
      render :edit
    end
  end

  private

  def collection_params
    params.require(:collection).permit([
      :name, :description, :user_id, { monuments_attributes: [ :name ] }
    ])
  end
end
