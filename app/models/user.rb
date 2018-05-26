class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable##,:confirmable
  validates :name,  presence: true, length: { maximum: 30 }, on: :create
  validates :email, presence: true, length: { maximum: 255 }, on: :create,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  before_save { email.downcase! }
  has_many :places, dependent: :destroy
end