class Seed

  def self.start
    seed = Seed.new
    seed.generate_users
    seed.generate_roles
    seed.generate_predefined_users
    seed.generate_amenities
    seed.generate_listings
    seed.generate_listing_amenities
    seed.generate_images
    seed.generate_reservations
    seed.generate_traveler_user_roles
    seed.generate_host_user_roles
  end

  def generate_users
    1000.times do |i|
      user = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.unique.free_email,
        about_me: Faker::Hipster.paragraph,
        user_photo: "http://robohash.org/#{i}.png",
        phone_number: Faker::PhoneNumber.unique.cell_phone,
        password: "password"
      )
      puts "User #{user.last_name}, #{user.first_name} created!"
    end
  end

  def generate_listings
    1000.times do |i|
      user = User.find(Random.new.rand(1..1000))
      listing = Listing.create!(
        user_id: user.id,
        title: Faker::Company.catch_phrase,
        street_address: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zipcode: Faker::Address.zip,
        max_occupancy: Faker::Number.between(1, 30),
        description: Faker::Hipster.paragraph,
        list_category: ["Entire home/apt", "Private room", "Shared room"].sample,
        number_beds:Faker::Number.between(1, 30),
        number_rooms: Faker::Number.between(1, 30),
        number_baths: Faker::Number.between(1, 5),
        cost_per_night: Faker::Number.between(1, 350))
        puts "Listing #{listing.title} created!"
    end
  end

  def generate_images
    listing = Listing.all.each do |listing|
      3.times do
        image = Image.create!(
          image_url: Faker::LoremPixel.image("700x400", false, 'city'),
          listing_id: listing.id
          )
          puts "Image for #{image.listing_id} created!"
      end
    end
  end

  def generate_reservations
    3000.times do |i|
      listing = Listing.find(Random.new.rand(1..1000))
      user = User.find(Random.new.rand(1..1000))
      start_date = Faker::Date.between(Date.today, 1.year.from_now)
      end_date = Faker::Date.between(start_date, 1.year.from_now)
      reservation = Reservation.create!(
        start_date: start_date,
        end_date: end_date,
        listing_id: listing.id,
        status: ["confirmed", "pending", "cancelled", "complete"].sample,
        user_id: user.id
      )
      puts "Reservation #{reservation.id} created!"
    end
  end

  def generate_roles
    Role.create!(title: "admin")
    puts "Admin role created!"
    Role.create!(title: "host")
    puts "Host role created!"
    Role.create!(title: "traveler")
    puts "Traveler role created!"
  end

  def generate_traveler_user_roles
    User.all.each do |user|
      traveler = Role.find_by(title: "traveler")
      user.user_roles.create!(role: traveler)
      puts "#{user.email} is now a traveler!"
    end
  end

  def generate_host_user_roles
    User.where('id % 3 = 0').each do |user|
      host = Role.find_by(title: "host")
      user.user_roles.create!(role: host)
      puts "#{user.email} is now a host!"
    end
  end

  def generate_predefined_users
    host = Role.find_by(title: "host")
    traveler = Role.find_by(title: "traveler")
    User.create!(email: "sample@email.com",
                 first_name: "sample",
                 last_name: "user",
                 about_me: "sample traveler user",
                 phone_number: "8183231121",
                 password: "password")
    User.create!(email: "host@email.com",
                 first_name: "host",
                 last_name: "user",
                 about_me: "sample traveler user",
                 phone_number: "8183231122",
                 password: "password")
  end

  def generate_amenities
      amenities = ["pets_allowed", "free_parking", "family_kid_friendly",
        "doorman", "pool", "hot_tub", "gym", "air_conditioning",
        "wheelchair_accessible", "internet", "smoking_allowed",
        "suitable_for_events", "wireless_internet", "indoor_fireplace",
        "breakfast", "kitchen", "cable_tv", "dryer", "hair_dryer", "washer",
        "tv", "buzzer_wireless_intercom", "iron", "essentials",
        "laptop_friendly_workspace", "heating", "private_entrance"]
      amenities.each do |amenity|
        Amenity.create!(name: amenity)
        puts "Amenity: #{amenity} created!"
      end
  end

  def generate_listing_amenities
    amenities = []
    5.times do
      amenities << Amenity.find(Random.new.rand(1..20))
    end
    Listing.all.each do |listing|
      amenities.each do |amenity|
        listing.listing_amenities.create!(amenity: amenity, value: true)
        puts "#{amenity.name} added to #{listing.title}"
      end
    end
  end
end

Seed.start
