class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }, on: :create
  validates :email, presence: true, length: { maximum: 255 }, on: :create,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  before_save { email.downcase! }
  has_many :blogs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_blogs, through: :favorites, source:'blog'
  mount_uploader :image, ImageUploader
  validates :image, presence: true, on: :update
end