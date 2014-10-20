class Picture < ActiveRecord::Base
  self.primary_key = 'uuid'

  attr_accessor :io

  before_save do
    self.uuid ||= SecureRandom.uuid
    uploader.store!(self.io)
  end

  after_destroy do
    uploader.delete_store_dir!
  end

  def id
    uuid
  end

  def uploader
    return unless self.uuid
    @uploader ||= PictureUploader.new(self)
  end
end
