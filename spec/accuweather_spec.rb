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
      let(:vancouver_wa) { Accuweather::Location.new(city: 'Vancouver',
                                                     state: 'Washington',
                                                     location: 'cityId:331419',
                                                     latitude: '45.63873',
                                                     longitude: '-122.6615') }
      let(:vancouver_ca) { Accuweather::Location.new(city: 'Vancouver',
                                                     state: 'Canada (British Columbia)',
                                                     location: 'cityId:53286',
                                                     latitude: '49.2448',
                                                     longitude: '-123.1154') }
      let(:search_location) { 'vancouver' }

      it 'returns an array of matching locations' do
        puts described_class.city_search(search_location)
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
end
