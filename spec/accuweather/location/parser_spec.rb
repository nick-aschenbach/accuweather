require 'spec_helper'

describe Accuweather::Location::Parser do
  subject { described_class.new(fixture) }

  describe '#cities' do
    context 'one or more cities match' do
      let(:fixture) { load_fixture('find-city.xml') }
      let(:vancouver_wa) { Accuweather::Location::City.new(id: 'cityId:331419',
                                                           city: 'Vancouver',
                                                           state: 'Washington',
                                                           latitude: '45.63873',
                                                           longitude: '-122.6615') }
      let(:vancouver_ca) { Accuweather::Location::City.new(id: 'cityId:53286',
                                                           city: 'Vancouver',
                                                           state: 'Canada (British Columbia)',
                                                           latitude: '49.2448',
                                                           longitude: '-123.1154') }
      let(:search_location) { 'vancouver' }

      it 'returns an array of matching location' do
        expect(subject.cities).to match_array([vancouver_wa, vancouver_ca])
      end
    end

    context 'no cities match' do
      let(:fixture) { load_fixture('find-city-no-matches.xml') }
      let(:search_location) { 'nowhere' }

      it 'returns an empty array' do
        expect(subject.cities).to eq([])
      end
    end

    context 'an error occurs' do
      let(:fixture) { load_fixture('find-city-no-location.xml') }
      let(:search_location) { 'error payload' }

      it 'returns an empty array' do
        expect(subject.cities).to eq([])
      end
    end

    context 'an exception is raised' do
      let(:fixture) { load_fixture('find-city-no-location.xml') }
      let(:search_location) { 'error payload' }

      before do
        allow(Net::HTTP).to receive(:get).and_raise(StandardError)
      end

      it 'returns an empty array' do
        expect(subject.cities).to eq([])
      end
    end
  end
end