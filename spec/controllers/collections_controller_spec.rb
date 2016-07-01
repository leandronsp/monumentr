describe CollectionsController, type: :controller do
  render_views

  let(:user) { User.make! }
  let(:collection) { OpenStruct.new(id: 1, user_id: user.id, name: 'col', monuments: []) }

  before do
    session[:user_id] = user.id
  end

  describe '.create' do
    let(:params) do
      Hash({
        collection: {
          name: 'Summer 2014',
          description: 'My cool Eurotrip',
          monuments_attributes: [{ name: 'Eiffel Tower' }]
        }
      })
    end

    it 'creates the collection and redirects to collection edit' do
      params[:collection].merge!(user_id: user.id)

      expect(Collection).to receive(:new).with(params[:collection]) { collection }
      expect(collection).to  receive(:save) { true }

      post :create, params: params
      expect(response).to redirect_to(edit_collection_path(1))
    end

    context 'invalid data' do
      it 'renders back' do
        params[:collection].merge!(user_id: user.id)

        expect(Collection).to receive(:new).with(params[:collection]) { collection }
        expect(collection).to receive(:save) { false }
        expect(collection).to receive_message_chain('errors.full_messages') { ['Name cannot be blank'] }

        post :create, params: params
        expect(response).to render_template(:new)
        expect(response.body).to match('Name cannot be blank')
      end
    end

    context 'unauthenticated' do
      it 'redirects to sign in page' do
        session[:user_id] = nil
        post :create
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  context '.edit' do
    it 'renders form with the collection' do
      expect(Collection).to receive(:find).with('1') { collection }
      get :edit, params: { id: collection.id }

      expect(response).to render_template(:edit)
    end

    context 'not the same user' do
      let(:collection) { OpenStruct.new(id: 1, user_id: 4) }

      it 'redirects to dashboard with error message' do
        expect(Collection).to receive(:find).with('1') { collection }
        get :edit, params: { id: collection.id }

        expect(response).to redirect_to(root_path)
      end
    end
  end

  context '.update' do
    let(:params) do
      Hash({
        collection: {
          name: 'Summer 2015',
          description: 'My cool Eurotrip'
        }
      })
    end

    it 'redirects to edit page' do
      expect(Collection).to receive(:find).with('1') { collection }
      expect(collection).to receive(:update_attributes).with(params[:collection]) { true }

      put :update, params: params.merge(id: collection.id)

      expect(response).to redirect_to(edit_collection_path(collection.id))
    end

    context 'invalid update' do
      it 'renders back with errors' do
        expect(Collection).to receive(:find).with('1') { collection }
        expect(collection).to receive(:update_attributes).with(params[:collection]) { false }
        expect(collection).to receive_message_chain('errors.full_messages') { ['Name cannot be blank'] }

        put :update, params: params.merge(id: collection.id)

        expect(response).to render_template(:edit)
        expect(response.body).to match('Name cannot be blank')
      end
    end
  end

end
