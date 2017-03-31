class AddNumberBathsSringToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :number_baths, :string
  end
end
