class User < ApplicationRecord
  has_secure_password

  validates :email, :first_name, :last_name, :phone_number, presence: true
  validates :email, uniqueness: true

  has_many :listings
  has_many :reservations

  has_many :user_roles
  has_many :roles, through: :user_roles
end
