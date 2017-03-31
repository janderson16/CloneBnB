Fabricator(:listing_amenity) do
  listing {Fabricate(:listing)}
  amenity {Fabricate(:amenity)}
end
