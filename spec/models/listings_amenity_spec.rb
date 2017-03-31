require 'rails_helper'

describe ListingsAmenity do
  describe "relationships" do
    it { should belong_to(:listing) }
    it { should belong_to(:amenity) }
  end
end
