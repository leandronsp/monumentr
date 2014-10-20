class Monument < ActiveRecord::Base
  belongs_to :collection
  has_many   :monument_pictures, dependent: :destroy
  has_many   :pictures,          through: :monument_pictures, dependent: :destroy

  accepts_nested_attributes_for :monument_pictures, allow_destroy: true
  accepts_nested_attributes_for :pictures,          allow_destroy: true
end
