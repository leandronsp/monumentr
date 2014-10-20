describe CollectionsController, type: :controller do
  render_views

  let(:user) { User.make! }

  describe '.create' do
    let(:collection) { double('collection', id: 1) }

    let(:params) do
      Hash({
        collection: {
          name: 'Summer 2014',
          description: 'My cool Eurotrip',
          monuments_attributes: [{ name: 'Eiffel Tower' }]
        }
      }).with_indifferent_access
    end

    it 'creates the collection and redirects to collection edit' do
      params[:collection].merge!(user_id: user.id)

      expect(Collection).to receive(:new).with(params[:collection]) { collection }
      expect(collection).to  receive(:save) { true }

      session[:user_id] = user.id
      post :create, params
      expect(response).to redirect_to(edit_collection_path(1))
    end

    context 'invalid data' do
      it 'renders back' do
        params[:collection].merge!(user_id: user.id)

        expect(Collection).to receive(:new).with(params[:collection]) { collection }
        expect(collection).to  receive(:save) { false }
        expect(collection).to  receive_message_chain('errors.full_messages') { ['Name cannot be blank'] }

        session[:user_id] = user.id
        post :create, params
        expect(response).to render_template(:new)
        expect(response.body).to match('Name cannot be blank')
      end
    end

    context 'unauthenticated' do
      it 'redirects to sign in page' do
        post :create
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

end
