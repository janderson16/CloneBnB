require 'rails_helper'

describe UserRole do
  describe "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:role) }
  end
end
