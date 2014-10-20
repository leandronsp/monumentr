describe Picture do
  let(:uploader)  { double('uploader') }

  before do
    allow(SecureRandom).to receive(:uuid)   { 'uuid' }
    allow(PictureUploader).to receive(:new) { uploader }
  end

  describe '.save' do
    context 'before_save' do
      let(:io)        { double('io') }
      let(:extension) { 'jpg' }

      it 'uploads data using the generated uuid' do
        expect(uploader).to receive(:store!).with(io)

        pic = Picture.create(io: io, extension: extension)

        expect(pic.uuid).to eq('uuid')
        expect(pic.extension).to eq('jpg')
      end

      context 'without io' do
        it 'does not save' do
          expect(uploader).to_not receive(:store!)

          Picture.create(extension: extension)
          expect(Picture.count).to eq(0)
        end
      end

      context 'without extension' do
        it 'does not save' do
          expect(uploader).to_not receive(:store!)

          Picture.create(io: io)
          expect(Picture.count).to eq(0)
        end
      end

      context 'unexpected error while uploading picture' do
        it 'does not save into database' do
          expect(uploader).to receive(:store!).with(io).and_raise StandardError

          expect { Picture.create(io: io, extension: extension) }
            .to raise_error(StandardError)

          expect(Picture.count).to eq(0)
        end
      end
    end
  end

  describe '.destroy' do
    context 'after_destroy' do
      it 'deletes store dir where picture was uploaded' do
        expect(uploader).to receive(:store!)
        expect(uploader).to receive(:delete_store_dir!)

        Picture.make!.destroy
      end
    end
  end

  describe '.url' do
    let(:pic) { Picture.make! }

    before do
      expect(uploader).to receive(:store!)
    end

    it 'returns the full path to the original image' do
      path = '/test/uuid/original.jpg'
      expect(pic.url).to eq(Settings.image_host + path)
    end

    it 'returns the full path to the square_100 version' do
      path = '/test/uuid/square_100.jpg'
      expect(pic.url(:square_100)).to eq(Settings.image_host + path)
    end
  end
end
