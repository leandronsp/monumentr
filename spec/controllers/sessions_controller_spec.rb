describe SessionsController, type: :controller do
  render_views

  describe '.create' do
    let(:user) { User.make! }

    before do
      post :create, params: { user: { email: user.email, password: '123' }}
    end

    it 'finds and put user_id into session' do
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to(root_path)
    end

    context 'invalid credentials' do
      before do
        post :create, params: { user: { email: user.email, password: 'invalid' }}
      end

      it 'renders back with error message' do
        expect(response).to render_template(:new)
        expect(response.body).to match('Email/Password invalid')
      end
    end
  end

  describe '.destroy' do
    before do
      get :destroy
    end

    it 'sets session user_id as nil' do
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end
