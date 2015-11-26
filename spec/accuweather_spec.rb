require 'spec_helper'

describe Accuweather do
  describe '.city_search' do
    let(:search_location) { 'vancouver' }

    before do
      fixture = load_fixture('find-city.xml')
      allow(Net::HTTP).to receive(:get)
                            .with('samsungmobile.accu-weather.com',
                                  "/widget/samsungmobile/city-find.asp?returnGeoPosition=1&location=#{search_location}")
                            .and_return(fixture)
    end

    it 'returns an array of cities' do
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

      it 'returns current conditions' do
        current = described_class.get_conditions(location_id: location_id).current
        expect(current.url).to eq('http://www.accuweather.com/m/en-us/US/CO/Winter Park/current.aspx?p=samsungmobile&cityId=347805')
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
        expect(current.precip).to eq('0.00')
        expect(current.uv_index).to eq('Low')
        expect(current.dewpoint).to eq('7')
        expect(current.cloud_cover).to eq('33%')
      end
    end

    describe 'fetching metric results' do
      context 'when not supplying a parameter' do
        it 'sets the accuweather metric query string parameter to 0' do
          expect(Net::HTTP).to receive(:get)
                                .with('samsungmobile.accu-weather.com',
                                      "/widget/samsungmobile/weather-data.asp?metric=0&location=#{location_id}")
                                .and_return(fixture)

          Accuweather.get_conditions(location_id: location_id)
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

          Accuweather.get_conditions(location_id: location_id, metric: true)
        end
      end
    end
  end
end
