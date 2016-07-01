class MonumentsController < ManageController
  before_action :check_ownership, only: [:edit, :update, :new]

  def new
    @collection ||= Collection.find(params[:collection_id])
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
    @monument   ||= fetch_monument
    @collection ||= fetch_collection
  end

  def update
    @monument   ||= fetch_monument
    @collection ||= fetch_collection

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
    ]).to_h
  end

  def fetch_monument
    @monument ||= Monument.find(params[:id])
  end

  def fetch_collection
    @collection ||= begin
      if params[:collection_id]
        Collection.find(params[:collection_id])
      else
        fetch_monument.collection
      end
    end
  end

  def check_ownership
    if fetch_collection.user_id != @current_user.id
      flash[:error] = 'You cannot do this!'
      redirect_to root_path
    end
  end
end
