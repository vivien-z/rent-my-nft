class Nft < ApplicationRecord
  scope :by_price, -> price_min, price_max { where("price >= ? AND price <= ?", price_min, price_max) }

  include PgSearch::Model

  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :image
  
  # Search setting
  pg_search_scope :search_by_nft_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true }
    }

  # Geocode address
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
