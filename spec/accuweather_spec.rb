require 'spec_helper'

describe Accuweather do
  describe '.city_search' do
    before do
      allow(Net::HTTP).to receive(:get)
                            .with('samsungmobile.accu-weather.com',
                                  "/widget/samsungmobile/city-find.asp?returnGeoPosition=1&location=#{search_location}")
                            .and_return(fixture)
    end

    context 'one or more cities match' do
      let(:fixture) { load_fixture('find-city.xml') }
      let(:vancouver_wa) { Accuweather::Location.new(id: 'cityId:331419',
                                                     city: 'Vancouver',
                                                     state: 'Washington',
                                                     latitude: '45.63873',
                                                     longitude: '-122.6615') }
      let(:vancouver_ca) { Accuweather::Location.new(id: 'cityId:53286',
                                                     city: 'Vancouver',
                                                     state: 'Canada (British Columbia)',
                                                     latitude: '49.2448',
                                                     longitude: '-123.1154') }
      let(:search_location) { 'vancouver' }

      it 'returns an array of matching locations' do
        expect(described_class.city_search(search_location)).to match_array([vancouver_wa, vancouver_ca])
      end
    end

    context 'no cities match' do
      let(:fixture) { load_fixture('find-city-no-matches.xml') }
      let(:search_location) { 'nowhere' }

      it 'returns an empty array' do
        expect(described_class.city_search(search_location)).to eq([])
      end
    end

    context 'an error occurs' do
      let(:fixture) { load_fixture('find-city-no-location.xml') }
      let(:search_location) { 'error payload' }

      it 'returns an empty array' do
        expect(described_class.city_search(search_location)).to eq([])
      end
    end

    context 'an exception is raised' do
      let(:fixture) { load_fixture('find-city-no-location.xml') }
      let(:search_location) { 'error payload' }

      before do
        allow(Net::HTTP).to receive(:get).and_raise(StandardError)
      end

      it 'returns an empty array' do
        expect(described_class.city_search(search_location)).to eq([])
      end
    end
  end

  describe '.get_conditions' do
    before do
      allow(Net::HTTP).to receive(:get)
                            .with('samsungmobile.accu-weather.com',
                                  "/widget/samsungmobile/weather-data.asp?metric=0&location=#{location_id}")
                            .and_return(fixture)
    end

    context 'when conditions are returned for the location' do
      let(:location_id) { 'cityId:331419' }
      let(:fixture) { load_fixture('get-conditions.xml') }

      it 'returns units' do
        units = described_class.get_conditions(location_id).units
        expect(units.temperature).to eq('F')
        expect(units.distance).to eq('MI')
        expect(units.speed).to eq('MPH')
        expect(units.pressure).to eq('IN')
        expect(units.precipitation).to eq('IN')
      end

      it 'returns local information' do
        local = described_class.get_conditions(location_id).local
        expect(local.city).to eq('Winter Park')
        expect(local.state).to eq('Colorado')
        expect(local.lat).to eq('39.89166')
        expect(local.lon).to eq('-105.7631')
        expect(local.time).to eq('21:14')
        expect(local.time_zone).to eq('-7')
        expect(local.obs_daylight).to eq('0')
        expect(local.current_gmt_offset).to eq('-7')
        expect(local.time_zone_abbreviation).to eq('MST')
      end

      it 'returns current conditions' do
        current = described_class.get_conditions(location_id).current
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
  end
end
