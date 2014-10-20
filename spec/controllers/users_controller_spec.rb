describe UsersController, type: :controller do
  render_views

  describe 'registration' do
    before do
      params = { name: 'Chuck Norris', email: 'chuck@norris.com' }
      post :create, user: params.merge(password: '123', password_confirmation: '123')
    end

    it 'registers the user and redirect to manage dashboard' do
      expected = User.where(email: 'chuck@norris.com').first
      expect(expected).to be

      expect(response).to redirect_to(root_path)
    end

    context 'duplicated email' do
      before do
        params = { name: 'Chuck Norris', email: 'chuck@norris.com' }
        post :create, user: params.merge(password: '123', password_confirmation: '123')
      end

      it 'render error message' do
        expect(response.body).to match('Account is taken')
      end
    end

    context 'missing email' do
      before do
        params = { name: 'Chuck Norris' }
        post :create, user: params.merge(password: '123', password_confirmation: '123')
      end

      it 'render error message' do
        expect(response.body).to match("Email can&#39;t be blank")
      end
    end
  end
end
