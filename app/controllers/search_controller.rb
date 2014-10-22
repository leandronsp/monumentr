class SearchController < ManageController
  def perform
    @collections = Search.collections(params[:term])

    @term = params[:term]
    render 'home/dashboard'
  end
end
