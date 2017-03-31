require 'rails_helper'

describe Message do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe "relationships" do
    it { should belong_to(:host) }
    it { should belong_to(:traveler) }
  end
end
