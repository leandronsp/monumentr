module Encryptor
  extend self

  def sha1_and_salt(source)
    salt = Digest::SHA1.hexdigest(SecureRandom.uuid)
    [sha1(source, salt), salt]
  end

  def sha1(source, salt)
    Digest::SHA1.hexdigest(source + salt)
  end
end
