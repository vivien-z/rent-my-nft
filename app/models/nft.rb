class Nft < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  has_one_attached :image
end
