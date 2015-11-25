module Accuweather
  module Conditions
    class Units
      attr_reader :temperature, :distance, :speed, :pressure, :precipitation

      def initialize(temperature:, distance:, speed:, pressure:, precipitation:)
        @temperature = temperature
        @distance = distance
        @speed = speed
        @pressure = pressure
        @precipitation = precipitation
      end

      def ==(other)
        temperature == other.temperature &&
          distance == other.distance &&
          speed == other.speed &&
          pressure == other.pressure &&
          precipitation == other.precipitation
      rescue NoMethodError
        false
      end

      def to_s
        "temperature: #{temperature}, distance: #{distance}, speed: #{speed}, pressure: #{pressure}, precipitation: #{precipitation}"
      end
    end
  end
end