class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :driver

  # input latitude and longitude. Auto generate address and fill to gps_location field  in database
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :reverse_geocode

  # input gps_location. Auto generate latitude and longitude
  geocoded_by :address, :latitude => :latitude, :longitude => :longitude
  after_validation :geocode, :reverse_geocode

  STATUS = {
    :pending    => 0,
    :accepted   => 1,
    :rejected   => 2
  }

end
