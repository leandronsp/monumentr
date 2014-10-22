class Monument < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search, :against => [:name, :description, :category]

  belongs_to :collection
  has_many   :monument_pictures, dependent: :destroy
  has_many   :pictures,          through: :monument_pictures, dependent: :destroy

  accepts_nested_attributes_for :monument_pictures, allow_destroy: true
  accepts_nested_attributes_for :pictures,          allow_destroy: true

  validates_presence_of :name

  def photos_count
    pictures.count
  end

  def thumb_url
    MonumentPicture
      .where(monument_id: id)
      .order('created_at DESC')
      .first
      .try(:picture).try(:url, :square_100)
  end
end
