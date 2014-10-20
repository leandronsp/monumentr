require 'machinist/active_record'

Picture.blueprint do
  uuid { 'uuid' }
  extension { 'jpg' }
end
