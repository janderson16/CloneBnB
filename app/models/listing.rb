class Listing < ApplicationRecord
  has_many :images
  has_many :reservations
  has_many :user_roles
  belongs_to :user
  has_many :listings_amenities
  has_many :amenities, through: :listings_amenities 
end
