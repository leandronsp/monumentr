class Collection < ActiveRecord::Base
  belongs_to :user
  has_many   :monuments, dependent: :destroy

  accepts_nested_attributes_for :monuments, allow_destroy: true

  validates_presence_of :name

  def thumb_url
    @thumb_url ||= begin
      if monuments.present?
        picture = monuments.first.pictures.first
        if picture.present?
          picture.url(:square_100)
        end
      end
    end
  end

  def monuments_count
    @monuments_count ||= monuments.count
  end

  def photos_count
    @photos_count ||= begin
      monuments.inject(0) do |sum, monument|
        sum += monument.pictures.count
      end
    end
  end
end