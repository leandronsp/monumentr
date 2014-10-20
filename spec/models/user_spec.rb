describe User do
  describe '.create' do
    it 'saves into database' do
      model = User.make!
      expect(model).to be
    end

    specify 'password confirmation invalid' do
      expect { User.make!(password_confirmation: nil) }.to raise_error
    end

    context 'duplicated email' do
      before do
        User.make!
      end

      it 'raises ActiveRecord::RecordNotUnique error' do
        expect{ User.make! }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end

  describe '.authenticate!' do
    before do
      User.make!
    end

    it 'returns the user' do
      expect(User.authenticate!('chuck@norris.com', '123')).to be
    end

    context 'invalid password' do
      it 'returns nil' do
        expect(User.authenticate!('chuck@norris.com', 'invalid')).to be_nil
      end
    end
  end
end
