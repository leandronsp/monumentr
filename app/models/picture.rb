class Picture < ActiveRecord::Base
  self.primary_key = 'uuid'

  attr_accessor :io

  validates_presence_of :extension

  before_validation do
    if self.extension.blank? && self.io.respond_to?(:original_filename)
      self.extension = File.extname(self.io.original_filename)[1..-1]
    end
  end

  before_save do
    if self.io.present?
      self.uuid ||= SecureRandom.uuid
      uploader.store!(self.io)
    else
      throw :abort
    end
  end

  after_destroy do
    uploader.delete_store_dir!
  end

  def id
    uuid
  end

  def url(version = :original)
    path = "/#{CarrierWave.root}/#{self.uuid}/#{version}.#{self.extension}"
    ::Settings.image_host + path
  end

  def uploader
    return unless self.uuid
    @uploader ||= PictureUploader.new(self)
  end
end
