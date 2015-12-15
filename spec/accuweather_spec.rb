require 'spec_helper'

describe Accuweather do
  describe '.city_search' do
    let(:data_to_compress) { <<-CSV }
cityId:351409|Seattle|Washington|47.60622|-122.3321
cityId:60449|Santiago|Chile (Region Metropolitana)|-33.44643|-70.65901
cityId:129846|Santiago|Ecuador (Pichincha)|-0.2295|-78.52428
    CSV
    let(:compressed_data) { Zlib::Deflate.deflate(data_to_compress) }

    before do
      allow(File).to receive(:read).with(Accuweather::Location::Cache::CITIES_CSV_FILE).and_return(compressed_data)
    end

    context 'when the search location is in the location cache' do
      let(:search_location) { 'seattle' }

      it 'returns a list of expected locations from the cache' do
        seatte = Accuweather::Location::City.new(id: 'cityId:351409',
                                                 city: 'Seattle',
                                                 state: 'Washington',
                                                 latitude: '47.60622',
                                                 longitude: '-122.3321')

        expect(described_class.city_search(name: search_location)).to eq([seatte])
      end

      it 'does not make a HTTP request' do
        expect(Net::HTTP).to_not receive(:get)

        described_class.city_search(name: search_location)
      end
    end

    context 'when the search location is not in the location cache' do
      let(:search_location) { 'vancouver' }

      before do
        fixture = load_fixture('find-city.xml')
        allow(Net::HTTP).to receive(:get)
                              .with('samsungmobile.accu-weather.com',
                                    "/widget/samsungmobile/city-find.asp?returnGeoPosition=1&location=#{search_location}")
                              .and_return(fixture)
      end

      it 'returns an array of cities from the web service' do
        cities = described_class.city_search(name: search_location)

        expect(cities[0].id).to eq('cityId:53286')
        expect(cities[0].city).to eq('Vancouver')
        expect(cities[0].state).to eq('Canada (British Columbia)')
        expect(cities[0].latitude).to eq('49.2448')
        expect(cities[0].longitude).to eq('-123.1154')

        expect(cities[1].id).to eq('cityId:331419')
        expect(cities[1].city).to eq('Vancouver')
        expect(cities[1].state).to eq('Washington')
        expect(cities[1].latitude).to eq('45.63873')
        expect(cities[1].longitude).to eq('-122.6615')
      end

      context 'when an error is raised' do
        before do
          allow(Net::HTTP).to receive(:get).and_raise(StandardError.new('foobar'))
        end

        it 'is rebranded and reraised as Accuweather::Error' do
          expect {
            described_class.city_search(name: search_location)
          }.to raise_error(Accuweather::Error, 'StandardError: foobar')
        end
      end
    end
  end

  describe '.get_conditions' do
    let(:location_id) { 'cityId:331419' }
    let(:fixture) { load_fixture('get-conditions.xml') }

    before do
      allow(Net::HTTP).to receive(:get)
                            .with('samsungmobile.accu-weather.com',
                                  "/widget/samsungmobile/weather-data.asp?metric=0&location=#{location_id}")
                            .and_return(fixture)
    end

    context 'when conditions are returned for the location' do
      it 'returns units' do
        units = described_class.get_conditions(location_id: location_id).units
        expect(units.temperature).to eq('F')
        expect(units.distance).to eq('MI')
        expect(units.speed).to eq('MPH')
        expect(units.pressure).to eq('IN')
        expect(units.precipitation).to eq('IN')
      end

      it 'returns local information' do
        local = described_class.get_conditions(location_id: location_id).local
        expect(local.city).to eq('Winter Park')
        expect(local.state).to eq('Colorado')
        expect(local.latitude).to eq('39.89166')
        expect(local.longitude).to eq('-105.7631')
        expect(local.time).to eq('21:14')
        expect(local.time_zone).to eq('-7')
        expect(local.obs_daylight).to eq('0')
        expect(local.current_gmt_offset).to eq('-7')
        expect(local.time_zone_abbreviation).to eq('MST')
      end
      
      it 'returns the moon and planet rise and set times' do
        planets = described_class.get_conditions(location_id: location_id).planets
        expect(planets.sunrise).to eq('6:57 AM')
        expect(planets.sunset).to eq('4:42 PM')
        expect(planets.moonrise).to eq('11/23/2015 3:30:00 PM')
        expect(planets.moonset).to eq('11/24/2015 5:15:00 AM')
        expect(planets.mercuryrise).to eq('2:14 PM')
        expect(planets.mercuryset).to eq('11:48 PM')
        expect(planets.venusrise).to eq('10:09 AM')
        expect(planets.venusset).to eq('9:46 PM')
        expect(planets.marsrise).to eq('9:21 AM')
        expect(planets.marsset).to eq('9:20 PM')
        expect(planets.jupiterrise).to eq('8:01 AM')
        expect(planets.jupiterset).to eq('8:41 PM')
        expect(planets.saturnrise).to eq('2:22 PM')
        expect(planets.saturnset).to eq('12:10 AM')
        expect(planets.uranusrise).to eq('9:36 PM')
        expect(planets.uranusset).to eq('10:23 AM')
        expect(planets.neptunerise).to eq('8:01 PM')
        expect(planets.neptuneset).to eq('7:03 AM')
        expect(planets.plutorise).to eq('5:06 PM')
        expect(planets.plutoset).to eq('2:44 AM')
      end

      it 'returns current conditions' do
        current = described_class.get_conditions(location_id: location_id).current
        expect(current.observation_time).to eq('9:14 PM')
        expect(current.pressure).to eq('30.12')
        expect(current.temperature).to eq('26')
        expect(current.real_feel).to eq('26')
        expect(current.humidity).to eq('44%')
        expect(current.weather_text).to eq('Partly cloudy')
        expect(current.weather_icon).to eq('35')
        expect(current.wind_gusts).to eq('11')
        expect(current.wind_speed).to eq('8')
        expect(current.wind_direction).to eq('SE')
        expect(current.visibility).to eq('8')
        expect(current.precipitation).to eq('0.00')
        expect(current.uv_index).to eq('Low')
        expect(current.dewpoint).to eq('7')
        expect(current.cloud_cover).to eq('33%')
      end

      it 'returns first days forecast' do
        first_day = described_class.get_conditions(location_id: location_id).forecast.first
        expect(first_day.date).to eq('11/23/2015')
        expect(first_day.day_of_week).to eq('Monday')
        expect(first_day.sunrise).to eq('6:57 AM')
        expect(first_day.sunset).to eq('4:42 PM')

        daytime = first_day.daytime
        expect(daytime.weather_text).to eq('Partly sunny')
        expect(daytime.weather_text_long).to eq('Partly sunny')
        expect(daytime.weather_icon).to eq('03')
        expect(daytime.high_temperature).to eq('44')
        expect(daytime.low_temperature).to eq('11')
        expect(daytime.real_feel_high).to eq('47')
        expect(daytime.real_feel_low).to eq('3')
        expect(daytime.wind_speed).to eq('5')
        expect(daytime.wind_direction).to eq('W')
        expect(daytime.wind_gust).to eq('11')
        expect(daytime.max_uv).to eq('3')
        expect(daytime.rain_amount).to eq('0.00')
        expect(daytime.snow_amount).to eq('0.0')
        expect(daytime.ice_amount).to eq('0.00')
        expect(daytime.precipitation_amount).to eq('0.00')
        expect(daytime.thunderstorm_probability).to eq('0')
        expect(daytime.rain_probability).to eq('0')
        expect(daytime.snow_probability).to eq('0')
        expect(daytime.ice_probability).to eq('0')
        expect(daytime.precipitation_probability).to eq('0')

        nighttime = first_day.nighttime
        expect(nighttime.weather_text).to eq('Mainly clear')
        expect(nighttime.weather_text_long).to eq('Mainly clear')
        expect(nighttime.weather_icon).to eq('34')
        expect(nighttime.high_temperature).to eq('44')
        expect(nighttime.low_temperature).to eq('11')
        expect(nighttime.real_feel_high).to eq('30')
        expect(nighttime.real_feel_low).to eq('13')
        expect(nighttime.wind_speed).to eq('3')
        expect(nighttime.wind_direction).to eq('W')
        expect(nighttime.wind_gust).to eq('7')
        expect(nighttime.max_uv).to eq('3')
        expect(nighttime.rain_amount).to eq('0.00')
        expect(nighttime.snow_amount).to eq('0.0')
        expect(nighttime.ice_amount).to eq('0.00')
        expect(nighttime.precipitation_amount).to eq('0.00')
        expect(nighttime.thunderstorm_probability).to eq('0')
        expect(nighttime.rain_probability).to eq('0')
        expect(nighttime.snow_probability).to eq('0')
        expect(nighttime.ice_probability).to eq('0')
        expect(nighttime.precipitation_probability).to eq('0')
      end

      it 'returns last days forecast' do
        last_day = described_class.get_conditions(location_id: location_id).forecast.last
        expect(last_day.date).to eq('11/29/2015')
        expect(last_day.day_of_week).to eq('Sunday')
        expect(last_day.sunrise).to eq('7:03 AM')
        expect(last_day.sunset).to eq('4:39 PM')

        daytime = last_day.daytime
        expect(daytime.weather_text).to eq('Mostly cloudy')
        expect(daytime.weather_text_long).to eq('Mostly cloudy with a stray flurry in the afternoon')
        expect(daytime.weather_icon).to eq('07')
        expect(daytime.high_temperature).to eq('34')
        expect(daytime.low_temperature).to eq('17')
        expect(daytime.real_feel_high).to eq('27')
        expect(daytime.real_feel_low).to eq('18')
        expect(daytime.wind_speed).to eq('7')
        expect(daytime.wind_direction).to eq('WNW')
        expect(daytime.wind_gust).to eq('11')
        expect(daytime.max_uv).to eq('2')
        expect(daytime.rain_amount).to eq('0.10')
        expect(daytime.snow_amount).to eq('0.7')
        expect(daytime.ice_amount).to eq('0.20')
        expect(daytime.precipitation_amount).to eq('0.07')
        expect(daytime.thunderstorm_probability).to eq('0')
        expect(daytime.rain_probability).to eq('0')
        expect(daytime.snow_probability).to eq('45')
        expect(daytime.ice_probability).to eq('10')
        expect(daytime.precipitation_probability).to eq('45')

        nighttime = last_day.nighttime
        expect(nighttime.weather_text).to eq('Colder with a bit of snow')
        expect(nighttime.weather_text_long).to eq('Mostly cloudy and colder with a bit of snow')
        expect(nighttime.weather_icon).to eq('19')
        expect(nighttime.high_temperature).to eq('34')
        expect(nighttime.low_temperature).to eq('17')
        expect(nighttime.real_feel_high).to eq('19')
        expect(nighttime.real_feel_low).to eq('7')
        expect(nighttime.wind_speed).to eq('6')
        expect(nighttime.wind_direction).to eq('WNW')
        expect(nighttime.wind_gust).to eq('11')
        expect(nighttime.max_uv).to eq('2')
        expect(nighttime.rain_amount).to eq('0.00')
        expect(nighttime.snow_amount).to eq('0.2')
        expect(nighttime.ice_amount).to eq('0.00')
        expect(nighttime.precipitation_amount).to eq('0.01')
        expect(nighttime.thunderstorm_probability).to eq('0')
        expect(nighttime.rain_probability).to eq('0')
        expect(nighttime.snow_probability).to eq('47')
        expect(nighttime.ice_probability).to eq('0')
        expect(nighttime.precipitation_probability).to eq('56')
      end
    end

    describe 'fetching metric results' do
      context 'when not supplying a parameter' do
        it 'sets the accuweather metric query string parameter to 0' do
          expect(Net::HTTP).to receive(:get)
                                 .with('samsungmobile.accu-weather.com',
                                       "/widget/samsungmobile/weather-data.asp?metric=0&location=#{location_id}")
                                 .and_return(fixture)

          described_class.get_conditions(location_id: location_id)
        end
      end

      context 'when metric is false' do
        it 'sets the accuweather metric query string parameter to 0' do
          expect(Net::HTTP).to receive(:get)
                                 .with('samsungmobile.accu-weather.com',
                                       "/widget/samsungmobile/weather-data.asp?metric=0&location=#{location_id}")
                                 .and_return(fixture)

          Accuweather.get_conditions(location_id: location_id, metric: false)
        end
      end

      context 'when metric is true' do
        it 'sets the accuweather metric query string parameter to 1' do
          expect(Net::HTTP).to receive(:get)
                                 .with('samsungmobile.accu-weather.com',
                                       "/widget/samsungmobile/weather-data.asp?metric=1&location=#{location_id}")
                                 .and_return(fixture)

          described_class.get_conditions(location_id: location_id, metric: true)
        end
      end
    end

    context 'when an error is raised' do
      before do
        allow(Net::HTTP).to receive(:get).and_raise(StandardError.new('foobar'))
      end

      it 'is rebranded and reraised as Accuweather::Error' do
        expect {
          described_class.get_conditions(location_id: location_id, metric: true)
        }.to raise_error(Accuweather::Error, 'StandardError: foobar')
      end
    end
  end
end
