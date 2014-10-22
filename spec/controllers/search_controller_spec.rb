describe SearchController, type: :controller do
  render_views

  before do
    session[:user_id] = User.make!.id
  end

  describe '.perform' do
    it 'renders dashboard with found collections' do
      summer = OpenStruct.new(id: 1, name: 'summer')
      winter = OpenStruct.new(id: 2, name: 'winter')
      autumn = OpenStruct.new(id: 3, name: 'winter')
      eiffel = OpenStruct.new(id: 1, name: 'eiffel summer', collection: winter)

      expect(Search).to receive(:collections).with('summer')   { [summer, winter] }

      get :perform, term: 'summer'
      expect(response).to render_template('home/dashboard')
    end
  end
end
