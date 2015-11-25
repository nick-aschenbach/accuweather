module Accuweather
  module Conditions
    class Units
      attr_reader :temp, :dist, :speed, :pres, :prec

      def initialize(temp:, dist:, speed:, pres:, prec:)
        @temp = temp
        @dist = dist
        @speed = speed
        @pres = pres
        @prec = prec
      end

      def ==(other)
        temp == other.temp &&
          dist == other.dist &&
          speed == other.speed &&
          pres == other.pres &&
          prec == other.prec
      rescue NoMethodError
        false
      end

      def to_s
        "temp: #{temp}, dist: #{dist}, speed: #{speed}, pres: #{pres}, prec: #{prec}"
      end
    end
  end
end