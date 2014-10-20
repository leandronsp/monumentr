describe PictureUploader do
  let(:file) { File.new('spec/support/pictures/1.jpg') }

  subject do
    PictureUploader.new(Picture.make!)
  end

  describe '.store' do
    before do
      subject.store!(file)
    end

    it 'stores the original file' do
      expect(subject.file.exists?).to be_true

      expect(subject.file.file).to eq(
        File.join(Rails.root, 'test/uuid/original.jpg')
      )
    end

    it 'stores the square_100 version' do
      expect(subject.square_100.file.exists?).to be_true
      expect(subject.square_100.file.file).to eq(
        File.join(Rails.root, 'test/uuid/square_100.jpg')
      )
    end

    specify 'path, dir, filename' do
      expect(subject.store_dir).to eq('uuid')
      expect(subject.cache_dir).to eq('/tmp/monumentr-cache')
      expect(subject.full_path).to eq(File.join(Rails.root, 'test/uuid/original.jpg'))
      expect(subject.fetch_image!).to be
      expect(subject.open_raw_image).to be
    end
  end

  describe '.delete_store_dir!' do
    before do
      subject.store!(file)
      expect(Dir.exists?(File.dirname(subject.full_path))).to be_true
      subject.delete_store_dir!
    end

    it 'deletes the store dir' do
      expect(subject.file.exists?).to be_false
      expect(subject.square_100.file.exists?).to be_false
      expect(Dir.exists?(File.dirname(subject.full_path))).to be_false
    end
  end
end
