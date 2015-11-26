module Accuweather
  module Conditions
    class Parser
      def initialize(response)
        @doc = Nokogiri::XML.parse(response)
      end

      def units
        units = @doc.css('units').first
        Accuweather::Conditions::Units.new(temperature: units.css('temp').text,
                                           distance: units.css('dist').text,
                                           speed: units.css('speed').text,
                                           pressure: units.css('pres').text,
                                           precipitation: units.css('prec').text)
      end

      def local
        local = @doc.css('local').first
        Accuweather::Conditions::Local.new(city: local.css('city').text,
                                           state: local.css('state').text,
                                           latitude: local.css('lat').text,
                                           longitude: local.css('lon').text,
                                           time: local.css('time').text,
                                           time_zone: local.css('timeZone').text,
                                           obs_daylight: local.css('obsDaylight').text.strip,
                                           current_gmt_offset: local.css('currentGmtOffset').text,
                                           time_zone_abbreviation: local.css('timeZoneAbbreviation').text,
        )
      end

      def current
        current = @doc.css('currentconditions').first
        Accuweather::Conditions::Current.new(url: current.css('url').text,
                                             observation_time: current.css('observationtime').text,
                                             pressure: current.css('pressure').text,
                                             temperature: current.css('temperature').text,
                                             real_feel: current.css('realfeel').text,
                                             humidity: current.css('humidity').text,
                                             weather_text: current.css('weathertext').text,
                                             weather_icon: current.css('weathericon').text,
                                             wind_gusts: current.css('windgusts').text,
                                             wind_speed: current.css('windspeed').text,
                                             wind_direction: current.css('winddirection').text,
                                             visibility: current.css('visibility').text,
                                             precip: current.css('precip').text,
                                             uv_index: current.css('uvindex').text,
                                             dewpoint: current.css('dewpoint').text,
                                             cloud_cover: current.css('cloudcover').text,
        )
      end
    end
  end
end