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

      def planets
        planets = @doc.css('planets').first

        Accuweather::Conditions::Planets.new(
          sunrise: planets.css('sun').first['rise'],
          sunset: planets.css('sun').first['set'],
          moonrise: planets.css('moon').first['rise'],
          moonset: planets.css('moon').first['set'],
          mercuryrise: planets.css('mercury').first['rise'],
          mercuryset: planets.css('mercury').first['set'],
          venusrise: planets.css('venus').first['rise'],
          venusset: planets.css('venus').first['set'],
          marsrise: planets.css('mars').first['rise'],
          marsset: planets.css('mars').first['set'],
          jupiterrise: planets.css('jupiter').first['rise'],
          jupiterset: planets.css('jupiter').first['set'],
          saturnrise: planets.css('saturn').first['rise'],
          saturnset: planets.css('saturn').first['set'],
          uranusrise: planets.css('uranus').first['rise'],
          uranusset: planets.css('uranus').first['set'],
          neptunerise: planets.css('neptune').first['rise'],
          neptuneset: planets.css('neptune').first['set'],
          plutorise: planets.css('pluto').first['rise'],
          plutoset: planets.css('pluto').first['set'])
      end

      def current
        current = @doc.css('currentconditions').first
        Accuweather::Conditions::Current.new(observation_time: current.css('observationtime').text,
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
                                             precipitation: current.css('precip').text,
                                             uv_index: current.css('uvindex').text,
                                             dewpoint: current.css('dewpoint').text,
                                             cloud_cover: current.css('cloudcover').text,
        )
      end


      def forecast
        @doc.css('day').map do |forecast_day|
          day = extract_forcast_time(forecast_day, 'daytime')
          night = extract_forcast_time(forecast_day, 'nighttime')

          Accuweather::Conditions::ForecastDay.new(date: forecast_day.css('obsdate').text,
                                                   day_of_week: forecast_day.css('daycode').text,
                                                   sunrise: forecast_day.css('sunrise').text,
                                                   sunset: forecast_day.css('sunset').text,
                                                   daytime: day,
                                                   nighttime: night)
        end
      end

      private

      def extract_forcast_time(forecast_day, day_or_night)
        Accuweather::Conditions::ForecastWeather.new(weather_text: forecast_day.css("#{day_or_night}/txtshort").text,
                                                     weather_text_long: forecast_day.css("#{day_or_night}/txtlong").text,
                                                     weather_icon: forecast_day.css("#{day_or_night}/weathericon").text,
                                                     high_temperature: forecast_day.css("#{day_or_night}/hightemperature").text,
                                                     low_temperature: forecast_day.css("#{day_or_night}/lowtemperature").text,
                                                     real_feel_high: forecast_day.css("#{day_or_night}/realfeelhigh").text,
                                                     real_feel_low: forecast_day.css("#{day_or_night}/realfeellow").text,
                                                     wind_speed: forecast_day.css("#{day_or_night}/windspeed").text,
                                                     wind_direction: forecast_day.css("#{day_or_night}/winddirection").text,
                                                     wind_gust: forecast_day.css("#{day_or_night}/windgust").text,
                                                     max_uv: forecast_day.css("#{day_or_night}/maxuv").text,
                                                     rain_amount: forecast_day.css("#{day_or_night}/rainamount").text,
                                                     snow_amount: forecast_day.css("#{day_or_night}/snowamount").text,
                                                     ice_amount: forecast_day.css("#{day_or_night}/iceamount").text,
                                                     precipitation_amount: forecast_day.css("#{day_or_night}/precipamount").text,
                                                     thunderstorm_probability: forecast_day.css("#{day_or_night}/tstormprob").text,
                                                     rain_probability: forecast_day.css("#{day_or_night}/rainProbability").text,
                                                     snow_probability: forecast_day.css("#{day_or_night}/snowProbability").text,
                                                     ice_probability: forecast_day.css("#{day_or_night}/iceProbability").text,
                                                     precipitation_probability: forecast_day.css("#{day_or_night}/precipitationProbability").text)
      end
    end
  end
end