class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :nft

  validates :starting_date, :ending_date, presence: true
  validate :ending_date_after_starting_date

  private

  def ending_date_after_starting_date
    return if ending_date.blank? || starting_date.blank?

    if ending_date < starting_date
      errors.add(:ending_date, "must be after the start date")
    end
  end
end
