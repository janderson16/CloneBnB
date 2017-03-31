class CreateListingsAmenities < ActiveRecord::Migration[5.0]
  def change
    create_table :listings_amenities do |t|
      t.references :listing, foreign_key: true
      t.references :amenity, foreign_key: true
    end
  end
end
