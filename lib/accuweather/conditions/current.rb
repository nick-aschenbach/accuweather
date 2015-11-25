module Accuweather
  module Conditions
    class Current
      attr_reader :url, :observation_time, :pressure, :temperature, :real_feel, :humidity, :weather_text, :weather_icon, :wind_gusts, :wind_speed, :wind_direction, :visibility, :precip, :uv_index, :dewpoint, :cloud_cover

      def initialize(url:, observation_time:, pressure:, temperature:, real_feel:, humidity:, weather_text:, weather_icon:, wind_gusts:, wind_speed:, wind_direction:, visibility:, precip:, uv_index:, dewpoint:, cloud_cover:)
        @url = url
        @observation_time = observation_time
        @pressure = pressure
        @temperature = temperature
        @real_feel = real_feel
        @humidity = humidity
        @weather_text = weather_text
        @weather_icon = weather_icon
        @wind_gusts = wind_gusts
        @wind_speed = wind_speed
        @wind_direction = wind_direction
        @visibility = visibility
        @precip = precip
        @uv_index = uv_index
        @dewpoint = dewpoint
        @cloud_cover = cloud_cover
      end

      def ==(other)
        url == other.url &&
        observation_time == other.observation_time &&
        pressure == other.pressure &&
        temperature == other.temperature &&
        real_feel == other.real_feel &&
        humidity == other.humidity &&
        weather_text == other.weather_text &&
        weather_icon == other.weather_icon &&
        wind_gusts == other.wind_gusts &&
        wind_speed == other.wind_speed &&
        wind_direction == other.wind_direction &&
        visibility == other.visibility &&
        precip == other.precip &&
        uv_index == other.uv_index &&
        dewpoint == other.dewpoint &&
        cloud_cover == other.cloud_cover
      rescue NoMethodError
        false
      end

      def to_s
         "url: #{url}, observation_time: #{observation_time}, pressure: #{pressure}, temperature: #{temperature}, real_feel: #{real_feel}, humidity: #{humidity}, weather_text: #{weather_text}, weather_icon: #{weather_icon}, wind_gusts: #{wind_gusts}, wind_speed: #{wind_speed}, wind_direction: #{wind_direction}, visibility: #{visibility}, precip: #{precip}, uv_index: #{uv_index}, dewpoint: #{dewpoint}, cloud_cover: #{cloud_cover}"
      end
    end
  end
end