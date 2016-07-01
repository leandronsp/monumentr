describe HomeController, type: :controller do
  render_views

  let(:collection) { Collection.make! name: 'My collection' }

  before do
    session[:user_id] = collection.user.id
  end

  describe '.index' do
    it 'renders the dashbord with collections' do
      get :index
      expect(response.body).to match('My collection')
    end
  end

end
