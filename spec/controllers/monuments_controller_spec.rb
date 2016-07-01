describe MonumentsController, type: :controller do
  render_views

  let(:user) { User.make! }
  let(:collection) { OpenStruct.new(id: 1, user_id: user.id, name: 'col', monuments: []) }
  let(:monument)   { OpenStruct.new(id: 1, collection_id: collection.id, name: 'eiffel', pictures: []) }

  before do
    session[:user_id] = user.id
  end

  describe '.create' do
    let(:params) do
      Hash({
        monument: {
          name: 'Louvre',
          description: 'Paris FTW',
          category: 'museum',
          collection_id: collection.id.to_s
        }
      })
    end

    it 'redirects to monument edit page' do
      expect(Monument).to receive(:new).with(params[:monument]) { monument }
      expect(Collection).to receive(:find).with(params[:monument][:collection_id].to_i) { collection }
      expect(monument).to receive(:save) { true }

      post :create, params: params
      expect(response).to redirect_to(edit_monument_path(1))
    end

    context 'invalid data' do
      it 'renders back' do
        expect(Monument).to receive(:new).with(params[:monument]) { monument }
        expect(Collection).to receive(:find).with(params[:monument][:collection_id].to_i) { collection }
        expect(monument).to receive(:save) { false }
        expect(monument).to receive_message_chain('errors.full_messages') { ['Name cannot be blank'] }

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
    it 'renders form with the monument' do
      expect(Monument).to receive(:find).with('1') { monument }
      expect(monument).to receive(:collection) { collection }
      get :edit, params: { id: monument.id }

      expect(response).to render_template(:edit)
    end

    context 'not the same user' do
      let(:collection) { OpenStruct.new(id: 1, user_id: 4) }

      it 'redirects to dashboard with error message' do
        expect(Monument).to receive(:find).with('1') { monument }
        expect(monument).to receive(:collection) { collection }
        get :edit, params: { id: monument.id }

        expect(response).to redirect_to(root_path)
      end
    end
  end

  context '.update' do
    let(:params) do
      Hash({
        monument: {
          name: 'eiffel tower',
          description: 'My cool Eurotrip'
        }
      })
    end

    it 'redirects to edit page' do
      expect(Monument).to receive(:find).with('1') { monument }
      expect(monument).to receive(:collection) { collection }
      expect(monument).to receive(:update_attributes).with(params[:monument]) { true }

      put :update, params: params.merge(id: monument.id)

      expect(response).to redirect_to(edit_monument_path(monument.id))
    end

    context 'invalid update' do
      it 'renders back with errors' do
        expect(Monument).to receive(:find).with('1') { monument }
        expect(monument).to receive(:collection) { collection }
        expect(monument).to receive(:update_attributes).with(params[:monument]) { false }
        expect(monument).to receive_message_chain('errors.full_messages') { ['Name cannot be blank'] }

        put :update, params: params.merge(id: monument.id)

        expect(response).to render_template(:edit)
        expect(response.body).to match('Name cannot be blank')
      end
    end
  end

  describe '.new' do
    it 'renders the monument form for a specific collection' do
      expect(Collection).to receive(:find).with('1') { collection }
      get :new, params: { collection_id: collection.id }
      expect(response).to render_template(:new)
    end

    context 'user is trying to create a monument in someone elses collection' do
      it 'redirects to root_path' do
        collection = OpenStruct.new(id: 1, user_id: 4, monuments: [])
        expect(Collection).to receive(:find).with('1') { collection }

        get :new, params: { collection_id: collection.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
