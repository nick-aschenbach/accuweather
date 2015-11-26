require 'spec_helper'

describe Accuweather::Location::City do
  subject { Accuweather::Location::City.new(id: 'cityId:53286',
                                            city: 'Vancouver',
                                            state: 'Canada (British Columbia)',
                                            latitude: '49.2448',
                                            longitude: '-123.1154') }

  describe 'accessors' do
    it 'allows accesses the initialized attributes' do
      expect(subject.id).to eq('cityId:53286')
      expect(subject.city).to eq('Vancouver')
      expect(subject.state).to eq('Canada (British Columbia)')
      expect(subject.latitude).to eq('49.2448')
      expect(subject.longitude).to eq('-123.1154')
    end
  end

  describe '#==' do
    context 'with two objects with the same attributes' do
      it 'returns true' do
        expect(subject).to eq(Accuweather::Location::City.new(id: 'cityId:53286',
                                                              city: 'Vancouver',
                                                              state: 'Canada (British Columbia)',
                                                              latitude: '49.2448',
                                                              longitude: '-123.1154'))
      end
    end

    context 'with two objects that vary' do
      it 'returns false' do
        expect(subject).to_not eq(Accuweather::Location::City.new(id: 'cityId:53286',
                                                                  city: 'Not Vancouver',
                                                                  state: 'Canada (British Columbia)',
                                                                  latitude: '49.2448',
                                                                  longitude: '-123.1154'))
      end
    end

    context 'with different objects' do
      it 'returns false' do
        expect(subject).to_not eq('completely-different-object')
      end
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the object' do
      expect(subject.to_s).to eq('id: cityId:53286, city: Vancouver, state: Canada (British Columbia), latitude: 49.2448, longitude: -123.1154')
    end
  end
end