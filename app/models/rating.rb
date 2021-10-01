class Rating < ApplicationRecord
  belongs_to :store

  validates :value, :opinion, :user_name, presence: true
end
