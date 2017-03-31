require 'rails_helper'

describe Image do
  describe "validations" do
    it { should validate_presence_of(:image_url) }
  end

  describe "relationships" do
    it { should belong_to(:listing) }
  end
end
