class ChangeColumnInLitings < ActiveRecord::Migration[5.0]
  def change
    change_column :listings, :number_baths, :string
  end
end
