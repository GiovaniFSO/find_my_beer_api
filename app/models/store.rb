class Store < ApplicationRecord
  has_many :ratings, dependent: :destroy

  validates :name, :google_place_id, :lonlat, presence: true
  validates :google_place_id, uniqueness: true

  scope :within, lambda { |longitude, latitude, distance_in_km = 5|
    where(format(%{ ST_Distance(lonlat, 'POINT(%f %f)') < %d
         }, longitude, latitude, distance_in_km * 1000))
  }
end
