module Accuweather
  module Conditions
    class ForecastDay
      attr_reader :date, :day_of_week, :sunrise, :sunset, :daytime, :nighttime

      def initialize(date:, day_of_week:, sunrise:, sunset:, daytime:, nighttime:)
        @date = date
        @day_of_week = day_of_week
        @sunrise = sunrise
        @sunset = sunset
        @daytime = daytime
        @nighttime = nighttime
      end

      def ==(other)
        date == other.date &&
          day_of_week == other.day_of_week &&
          sunrise == other.sunrise &&
          sunset == other.sunset &&
          daytime == other.daytime &&
          nighttime == other.nighttime
      rescue NoMethodError
        false
      end

      def to_s
        "date: #{date}, day_of_week: #{day_of_week}, sunrise: #{sunrise}, sunset: #{sunset}, daytime: #{daytime}, nighttime: #{nighttime}"
      end
    end
  end
end