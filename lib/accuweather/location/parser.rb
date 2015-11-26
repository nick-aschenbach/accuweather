module Accuweather
  module Location
    class Parser
      def initialize(response)
        @doc = Nokogiri::XML.parse(response)
      end

      def cities
        @doc.css('location').map do |location|
          Accuweather::Location::City.new(id: location.attr('location'),
                                          city: location.attr('city'),
                                          state: location.attr('state'),
                                          latitude: location.attr('latitude'),
                                          longitude: location.attr('longitude'))
        end
      end
    end
  end
end