module Accuweather
  module Conditions
    class Planets
      attr_reader :sunrise, :sunset, :moonrise, :moonset, :mercuryrise, :mercuryset, :venusrise, :venusset, :marsrise, :marsset, :jupiterrise, :jupiterset, :saturnrise, :saturnset, :uranusrise, :uranusset, :neptunerise, :neptuneset, :plutorise, :plutoset

      def initialize(sunrise:, sunset:, moonrise:, moonset:, mercuryrise:, mercuryset:, venusrise:, venusset:, marsrise:, marsset:, jupiterrise:, jupiterset:, saturnrise:, saturnset:, uranusrise:, uranusset:, neptunerise:, neptuneset:, plutorise:, plutoset:)
        @sunrise = sunrise
        @sunset = sunset
        @moonrise = moonrise
        @moonset = moonset
        @mercuryrise = mercuryrise
        @mercuryset = mercuryset
        @venusrise = venusrise
        @venusset = venusset
        @marsrise = marsrise
        @marsset = marsset
        @jupiterrise = jupiterrise
        @jupiterset = jupiterset
        @saturnrise = saturnrise
        @saturnset = saturnset
        @uranusrise = uranusrise
        @uranusset = uranusset
        @neptunerise = neptunerise
        @neptuneset = neptuneset
        @plutorise = plutorise
        @plutoset = plutoset
      end

      def ==(other)
        sunrise == other.sunrise &&
        sunset == other.sunset &&
        moonrise == other.moonrise &&
        moonset == other.moonset &&
        mercuryrise == other.mercuryrise &&
        mercuryset == other.mercuryset &&
        venusrise == other.venusrise &&
        venusset == other.venusset &&
        marsrise == other.marsrise &&
        marsset == other.marsset &&
        jupiterrise == other.jupiterrise &&
        jupiterset == other.jupiterset &&
        saturnrise == other.saturnrise &&
        saturnset == other.saturnset &&
        uranusrise == other.uranusrise &&
        uranusset == other.uranusset &&
        neptunerise == other.neptunerise &&
        neptuneset == other.neptuneset &&
        plutorise == other.plutorise &&
        plutoset == other.plutoset
      rescue NoMethodError
        false
      end

      def to_s
        "sunrise: #{sunrise}, sunset: #{sunset}, moonrise: #{moonrise}, moonset: #{moonset}, mercuryrise: #{mercuryrise}, mercuryset: #{mercuryset}, venusrise: #{venusrise}, venusset: #{venusset}, marsrise: #{marsrise}, marsset: #{marsset}, jupiterrise: #{jupiterrise}, jupiterset: #{jupiterset}, saturnrise: #{saturnrise}, saturnset: #{saturnset}, uranusrise: #{uranusrise}, uranusset: #{uranusset}, neptunerise: #{neptunerise}, neptuneset: #{neptuneset}, plutorise: #{plutorise}, plutoset: #{plutoset}"
      end
    end
  end
end
