class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Versions

  def store_dir
    model.uuid
  end

  def cache_dir
    '/tmp/monumentr-cache'
  end

  def full_path
    path
  end

  def filename
    "original.#{model.extension}"
  end

  def fetch_image!
    self.retrieve_from_store!(filename)
    self
  end

  def open_raw_image
    MiniMagick::Image.open(full_path) rescue nil
  end

  def delete_store_dir!
    FileUtils.rm_rf(File.join(root, store_dir))
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
