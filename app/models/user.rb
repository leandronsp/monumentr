class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  has_many :collections, dependent: :destroy

  validates :email,                 presence: true
  validates :password,              confirmation: true
  validates :password_confirmation, presence: true

  before_save do
    if password.present? && password_confirmation.present?
      self.encrypted_password, self.salt = Encryptor.sha1_and_salt(password)
    end
  end

  after_save do
    self.password = nil
  end

  def self.authenticate!(email, password)
    user = User.where(email: email).first
    return unless user

    encrypted = Encryptor.sha1(password, user.salt)
    User.where(encrypted_password: encrypted).first
  end

end
