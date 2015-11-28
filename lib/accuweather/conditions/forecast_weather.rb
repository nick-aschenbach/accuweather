module Accuweather
  module Conditions
    class ForecastWeather
      attr_reader :weather_text, :weather_text_long, :weather_icon, :high_temperature, :low_temperature, :real_feel_high, :real_feel_low, :wind_speed, :wind_direction, :wind_gust, :max_uv, :rain_amount, :snow_amount, :ice_amount, :precipitation_amount, :thunderstorm_probability, :rain_probability, :snow_probability, :ice_probability, :precipitation_probability

      def initialize(weather_text:, weather_text_long:, weather_icon:, high_temperature:, low_temperature:, real_feel_high:, real_feel_low:, wind_speed:, wind_direction:, wind_gust:, max_uv:, rain_amount:, snow_amount:, ice_amount:, precipitation_amount:, thunderstorm_probability:, rain_probability:, snow_probability:, ice_probability:, precipitation_probability:)
        @weather_text = weather_text
        @weather_text_long = weather_text_long
        @weather_icon = weather_icon
        @high_temperature = high_temperature
        @low_temperature = low_temperature
        @real_feel_high = real_feel_high
        @real_feel_low = real_feel_low
        @wind_speed = wind_speed
        @wind_direction = wind_direction
        @wind_gust = wind_gust
        @max_uv = max_uv
        @rain_amount = rain_amount
        @snow_amount = snow_amount
        @ice_amount = ice_amount
        @precipitation_amount = precipitation_amount
        @thunderstorm_probability = thunderstorm_probability
        @rain_probability = rain_probability
        @snow_probability = snow_probability
        @ice_probability = ice_probability
        @precipitation_probability = precipitation_probability
      end

      def ==(other)
        weather_text == other.weather_text &&
        weather_text_long == other.weather_text_long &&
        weather_icon == other.weather_icon &&
        high_temperature == other.high_temperature &&
        low_temperature == other.low_temperature &&
        real_feel_high == other.real_feel_high &&
        real_feel_low == other.real_feel_low &&
        wind_speed == other.wind_speed &&
        wind_direction == other.wind_direction &&
        wind_gust == other.wind_gust &&
        max_uv == other.max_uv &&
        rain_amount == other.rain_amount &&
        snow_amount == other.snow_amount &&
        ice_amount == other.ice_amount &&
        precipitation_amount == other.precipitation_amount &&
        thunderstorm_probability == other.thunderstorm_probability &&
        rain_probability == other.rain_probability &&
        snow_probability == other.snow_probability &&
        ice_probability == other.ice_probability &&
        precipitation_probability == other.precipitation_probability
      rescue NoMethodError
        false
      end

      def to_s
        "weather_text: #{weather_text}, weather_text_long: #{weather_text_long}, weather_icon: #{weather_icon}, high_temperature: #{high_temperature}, low_temperature: #{low_temperature}, real_feel_high: #{real_feel_high}, real_feel_low: #{real_feel_low}, wind_speed: #{wind_speed}, wind_direction: #{wind_direction}, wind_gust: #{wind_gust}, max_uv: #{max_uv}, rain_amount: #{rain_amount}, snow_amount: #{snow_amount}, ice_amount: #{ice_amount}, precipitation_amount: #{precipitation_amount}, thunderstorm_probability: #{thunderstorm_probability}, rain_probability: #{rain_probability}, snow_probability: #{snow_probability}, ice_probability: #{ice_probability}, precipitation_probability: #{precipitation_probability}"
      end
    end
  end
end