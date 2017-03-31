require 'rails_helper'

describe Amenity do
  describe "validations" do
  end

  describe "relationships" do
    it { should have_many(:listings).through(:listings_amenities) }
  end
end
