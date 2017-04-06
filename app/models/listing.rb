class Listing < ApplicationRecord
  has_many :reservations
  has_many :images
  has_many :user_roles
  belongs_to :user
  has_many :listing_amenities
  has_many :amenities, through: :listing_amenities
  has_many :reviews

  validates_presence_of :street_address,
                        :description,
                        :city,
                        :state,
                        :zipcode,
                        :user,
                        :max_occupancy,
                        :number_beds,
                        :number_rooms,
                        :number_baths

  def range_available?(start_date, end_date)
    statuses = (start_date.to_date..end_date.to_date).to_a.map do |date|
      date_available?(date)
    end
    status = statuses.all? { |status| status == true }
  end

  def date_available?(date)
    check_start_and_end_dates(date.to_date) && check_middle_dates(date.to_date)
  end

  def check_start_and_end_dates(date)
    reservations.where(start_date: date).count == 0 && reservations.where(end_date: date).count == 0
  end

  def check_middle_dates(date)
    reservations.where('end_date >= ? AND start_date <= ?', date, date).count == 0
  end

  def user_stayed_at?(user)
    if user && user.reservations && user.reservations.find_by(listing_id: id).present?
      user.reservations.find_by(listing_id: id).status == "complete"
    end
  end

  def self.most_visits(parameters)
    select('listings.*, COUNT(reservations.listing_id) AS frequency')
      .where(city: parameters[:city])
      .joins(:reservations)
      .merge(Reservation.complete)
      .group(:id)
      .order('frequency desc')
      .limit(parameters[:limit])
  end

  def self.most_visits_all(parameters)
    select('listings.*, COUNT(reservations.listing_id) AS frequency')
      .joins(:reservations)
      .merge(Reservation.complete)
      .group(:id)
      .order('frequency desc')
      .limit(parameters[:limit])
  end

  def self.most_visited_cities
    joins(:reservations)
       .merge(Reservation.complete)
       .group(:city)
       .order('COUNT(reservations.listing_id) desc')
       .count
  end

  def self.list_by_city(city)
    Listing.where(city: city)
  end

  def self.listings_per_city
    self.group(:city).count
  end

  def host_name
    "#{user.first_name} #{user.last_name}"
  end

  def active_host?
    user.status == "active"
  end

  def host_phone
    user.phone_number
  end

  def number_reservations
    reservations.count
  end
end
