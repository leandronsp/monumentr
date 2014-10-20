describe Collection do
  describe '.destroy' do
    it 'destroys nested monuments and pictures' do
      picture    = Picture.make!
      monument   = Monument.make!
      collection = Collection.make!

      monument.pictures    << picture
      collection.monuments << monument

      expect(collection.reload.monuments.count).to eq(1)
      expect(monument.reload.pictures.count).to    eq(1)

      collection.destroy

      expect(Monument.where(id: monument.id).count).to eq(0)
      expect(Monument.count).to eq(0)

      expect(Picture.where(uuid: picture.id).count).to eq(0)
      expect(Picture.count).to eq(0)
    end
  end

  describe '.create' do
    context 'with nested attributes (monuments)' do
      it 'creates the collection with monuments' do
        params = Hash({
          collection: {
            name: 'Summer 2014' ,
            monuments_attributes: [
              { name: 'Monument 1' },
              { name: 'Monument 2' }
            ]
          }
        })

        collection = Collection.create(params[:collection])
        expect(collection.monuments.count).to eq(2)
      end
    end
  end

  describe 'thumb, monuments_count and photos_count' do
    let(:collection) { Collection.make! }

    before do
      monument = Monument.make!

      monument.pictures = [
        Picture.make!(uuid: 'uuid'),
        Picture.make!(uuid: 'guid')
      ]

      collection.monuments << monument
    end

    specify '.thumb_url' do
      expect(collection.thumb_url).to eq(Settings.image_host +
        '/test/uuid/square_100.jpg')
    end

    specify '.monuments_count' do
      expect(collection.monuments_count).to eq(1)
    end

    specify '.photos_count' do
      expect(collection.photos_count).to eq(2)
    end
  end
end
