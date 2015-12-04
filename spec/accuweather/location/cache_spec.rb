require 'spec_helper'

describe Accuweather::Location::Cache do
  let(:data_to_compress) { <<-CSV }
cityId:351409|Seattle|Washington|47.60622|-122.3321
cityId:60449|Santiago|Chile (Region Metropolitana)|-33.44643|-70.65901
cityId:129846|Santiago|Ecuador (Pichincha)|-0.2295|-78.52428
  CSV
  let(:compressed_data) { Zlib::Deflate.deflate(data_to_compress) }

  before do
    allow(File).to receive(:read).with(Accuweather::Location::Cache::CITIES_CSV_FILE).and_return(compressed_data)
  end

  describe '.cities' do
    shared_examples_for 'an action that returns expected locations' do
      it 'returns an array of expected locations' do
        expect(subject.cities(name: name)).to match_array(expected_locations)
      end
    end

    context 'with a single hit' do
      let(:name) { 'seattle' }
      let(:expected_locations) { [Accuweather::Location::City.new(id: 'cityId:351409',
                                                                  city: 'Seattle',
                                                                  state: 'Washington',
                                                                  latitude: '47.60622',
                                                                  longitude: '-122.3321')] }

      it_behaves_like 'an action that returns expected locations'
    end

    context 'with two hits' do
      let(:name) { 'sAnTiago' }
      let(:expected_locations) { [Accuweather::Location::City.new(id: 'cityId:60449',
                                                                  city: 'Santiago',
                                                                  state: 'Chile (Region Metropolitana)',
                                                                  latitude: '-33.44643',
                                                                  longitude: '-70.65901'),
                                  Accuweather::Location::City.new(id: 'cityId:129846',
                                                                  city: 'Santiago',
                                                                  state: 'Ecuador (Pichincha)',
                                                                  latitude: '-0.2295',
                                                                  longitude: '-78.52428')] }

      it_behaves_like 'an action that returns expected locations'
    end

    context 'when no hits' do
      [nil, '', 'nowhere'].each do |name|
        let(:name) { name }
        let(:expected_locations) { [] }

        it_behaves_like 'an action that returns expected locations'
      end
    end
  end
end