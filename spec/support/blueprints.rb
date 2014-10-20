require 'machinist/active_record'

Picture.blueprint do
  uuid { 'uuid' }
  extension { 'jpg' }
  io { File.new('spec/support/pictures/1.jpg') }
end

User.blueprint do
  name { 'Chuck Norris' }
  email { 'chuck@norris.com' }
  password { '123' }
  password_confirmation { '123' }
end

Collection.blueprint do
  name { 'Summer 2014' }
  user { User.make! }
end

Monument.blueprint do
  name { 'Eiffel Tower' }
end
