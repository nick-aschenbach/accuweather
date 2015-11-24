require 'spec_helper'

describe Accuweather::Location do
  subject { Accuweather::Location.new(city: 'Vancouver',
                                      state: 'Canada (British Columbia)',
                                      location: 'cityId:53286',
                                      latitude: '49.2448',
                                      longitude: '-123.1154') }

  describe 'accessors' do
    it 'allows accesses the initialized attributes' do
      expect(subject.city).to eq('Vancouver')
      expect(subject.state).to eq('Canada (British Columbia)')
      expect(subject.location).to eq('cityId:53286')
      expect(subject.latitude).to eq('49.2448')
      expect(subject.longitude).to eq('-123.1154')
    end
  end

  describe '==' do
    context 'with two objects with the same attributes' do
      it 'returns true' do
        expect(subject).to eq(Accuweather::Location.new(city: 'Vancouver',
                                                        state: 'Canada (British Columbia)',
                                                        location: 'cityId:53286',
                                                        latitude: '49.2448',
                                                        longitude: '-123.1154'))
      end
    end

    context 'with two objects that vary' do
      it 'returns false' do
        expect(subject).to_not eq(Accuweather::Location.new(city: 'Not Vancouver',
                                                        state: 'Canada (British Columbia)',
                                                        location: 'cityId:53286',
                                                        latitude: '49.2448',
                                                        longitude: '-123.1154'))
      end
    end
  end
end