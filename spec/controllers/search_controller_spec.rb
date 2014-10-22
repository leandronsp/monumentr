describe SearchController, type: :controller do
  render_views

  before do
    session[:user_id] = User.make!.id
  end

  describe '.perform' do
    it 'renders dashboard with found collections' do
      summer = OpenStruct.new(id: 1, name: 'summer')
      winter = OpenStruct.new(id: 2, name: 'winter')
      eiffel = OpenStruct.new(id: 3, name: 'eiffel summer', collection: winter)

      expect(Monument).to receive(:search).with('summer')   { [eiffel] }
      expect(Collection).to receive(:search).with('summer') { [summer] }

      get :perform, term: 'summer'
      expect(response).to render_template('home/dashboard')
    end
  end
end
