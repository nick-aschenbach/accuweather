module Accuweather
  module Conditions
    class Local
      attr_reader :city, :state, :lat, :lon, :time, :time_zone, :obs_daylight, :current_gmt_offset, :time_zone_abbreviation

      def initialize(city:, state:, lat:, lon:, time:, time_zone:, obs_daylight:, current_gmt_offset:, time_zone_abbreviation:)
        @city = city
        @state = state
        @lat = lat
        @lon = lon
        @time = time
        @time_zone = time_zone
        @obs_daylight = obs_daylight
        @current_gmt_offset = current_gmt_offset
        @time_zone_abbreviation = time_zone_abbreviation
      end

      def ==(other)
        city == other.city &&
          state == other.state &&
          lat == other.lat &&
          lon == other.lon &&
          time == other.time &&
          time_zone == other.time_zone &&
          obs_daylight == other.obs_daylight &&
          current_gmt_offset == other.current_gmt_offset &&
          time_zone_abbreviation == other.time_zone_abbreviation
      rescue NoMethodError
        false
      end

      def to_s
        "city: #{city}, state: #{state}, lat: #{lat}, lon: #{lon}, time: #{time}, time_zone: #{time_zone}, obs_daylight: #{obs_daylight}, current_gmt_offset: #{current_gmt_offset}, time_zone_abbreviation: #{time_zone_abbreviation}"
      end
    end
  end
end