module Accuweather
  class Location
    attr_reader :city, :state, :location, :latitude, :longitude

    def initialize(city:, state:, location:, latitude:, longitude:)
      @city = city
      @state = state
      @location = location
      @latitude = latitude
      @longitude = longitude
    end

    def ==(other)
      city == other.city &&
        state == other.state &&
        location == other.location &&
        latitude == other.latitude &&
        longitude == other.longitude
    end
  end
end