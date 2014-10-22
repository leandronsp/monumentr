class SearchController < ManageController
  def perform
    cols = Monument.search(params[:term]).map(&:collection)
    @collections = Collection.search(params[:term]) | cols

    @term = params[:term]
    render 'home/dashboard'
  end
end
