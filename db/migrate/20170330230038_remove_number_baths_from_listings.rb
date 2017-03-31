class RemoveNumberBathsFromListings < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :number_baths, :string
  end
end
