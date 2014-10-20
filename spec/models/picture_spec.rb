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
end
