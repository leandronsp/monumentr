describe Monument do
  describe '.destroy' do
    it 'destroys nested monuments' do
      picture  = Picture.make!
      monument = Monument.make!

      monument.pictures << picture

      expect(monument.reload.pictures.count).to eq(1)
      monument.destroy

      expect(Picture.where(uuid: picture.id).count).to eq(0)
      expect(Picture.count).to eq(0)
    end
  end

  describe '.create' do
    context 'with nested attributes (pictures)' do
      it 'creates the monument with pictures' do
        params = Hash({
          monument: {
            name: 'Eiffel Tower' ,
            pictures_attributes: [
              { io: File.new('spec/support/pictures/1.jpg'), extension: 'jpg' },
              { io: File.new('spec/support/pictures/1.jpg'), extension: 'jpg' }
            ]
          }
        })

        monument = Monument.create(params[:monument])
        expect(monument.pictures.count).to eq(2)
      end
    end
  end

  specify '.photos_count, .thumb_url' do
    monument = Monument.make!
    picture  = Picture.make!

    monument.pictures << picture

    expect(monument.photos_count).to eq(1)
    expect(monument.thumb_url).to eq(picture.url(:square_100))
  end
end
