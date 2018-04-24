class Picture < ApplicationRecord
  validates :content,  presence: true
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  mount_uploader :image, ImageUploader
end
