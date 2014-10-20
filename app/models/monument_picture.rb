##
# Join Table
##
class MonumentPicture < ActiveRecord::Base
  belongs_to :monument
  belongs_to :picture, dependent: :destroy
end
