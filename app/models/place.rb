class Place < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }
  validates :title,  presence: true
  validates :description,  presence: true
  validates :address,  presence: true
  belongs_to :user
  scope :get_by_category, ->(category) {
  where("category like ?", "%#{category}%")
  }
end
