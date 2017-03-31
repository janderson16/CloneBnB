class Listing < ApplicationRecord
  has_many :listings_amenities
  has_many :listings, through: :listings_amenities
end
