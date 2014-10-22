class MonumentsController < ManageController
  def new
    @collection = Collection.find(params[:collection_id])
  end

  def create
    @monument   = Monument.new(monument_params)
    @collection = Collection.find(@monument.collection_id)

    if @monument.save
      flash[:success] = 'Monument created!'
      redirect_to edit_monument_path(@monument.id)
    else
      flash.now[:error] = @monument.errors.full_messages.join(',')
      render :new
    end
  end

  def edit
    @monument   = Monument.find(params[:id])
    @collection = @monument.collection
  end

  def update
    @monument   = Monument.find(params[:id])
    @collection = @monument.collection

    if @monument.update_attributes(monument_params)
      flash[:success] = 'Monument Updated!'
      redirect_to edit_monument_path(@monument.id)
    else
      flash.now[:error] = @monument.errors.full_messages.join(',')
      render :edit
    end
  end

  private

  def monument_params
    params.require(:monument).permit([
      :name, :description, :category, :collection_id, { pictures_attributes: [ :io ] }
    ])
  end
end
