class Nft < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :image

  # Search setting
  default_scope {order("created_at DESC")}
  include PgSearch::Model
  pg_search_scope :search_by_name_and_synopsis,
    against: [ :name, :synopsis ],
    using: {
      tsearch: { prefix: true }
    }

  # Geocode address
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
