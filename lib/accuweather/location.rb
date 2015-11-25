module Accuweather
  class Location
    attr_reader :id, :city, :state, :latitude, :longitude

    def initialize(id:, city:, state:, latitude:, longitude:)
      @id = id
      @city = city
      @state = state
      @latitude = latitude
      @longitude = longitude
    end

    def ==(other)
      id == other.id &&
        city == other.city &&
        state == other.state &&
        latitude == other.latitude &&
        longitude == other.longitude
    rescue NoMethodError
      false
    end

    def to_s
      "id: #{id}, city: #{city}, state: #{state}, latitude: #{latitude}, longitude: #{longitude}"
    end
  end
end