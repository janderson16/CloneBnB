require 'rails_helper'

describe "user can see all listings available" do
  scenario "when they visit the listings index page" do
    listing_1, listing_2 = Fabricate.times(2, :listing)
    image_1 = Fabricate(:image, listing: listing_1)
    image_2 = Fabricate(:image, listing: listing_2)
    visit listings_path

    # binding.pry
    expect(page).to have_content(listing_1.title)
    # expect(page).to have_xpath("//img[@src='http://lorempixel.com/700/400/city']")
    page.all('a')[1].click

    page.find("img[src='http://lorempixel.com/700/400/city']")
    expect(page).to have_content(listing_2.title)
    expect(page).to have_content(listing_2.images.first.image_url)

  end
end
