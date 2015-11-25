require 'spec_helper'

describe Accuweather::Conditions::Local do
  subject { Accuweather::Conditions::Local.new(city: 'Winter Park',
                                               state: 'Colorado',
                                               lat: '39.89166',
                                               lon: '-105.7631',
                                               time: '21:14',
                                               time_zone: '-7',
                                               obs_daylight: '0',
                                               current_gmt_offset: '-7',
                                               time_zone_abbreviation: 'MST') }

  describe 'accessors' do
    it 'allows accessing the initialized attributes' do
      expect(subject.city).to eq('Winter Park')
      expect(subject.state).to eq('Colorado')
      expect(subject.lat).to eq('39.89166')
      expect(subject.lon).to eq('-105.7631')
      expect(subject.time).to eq('21:14')
      expect(subject.time_zone).to eq('-7')
      expect(subject.obs_daylight).to eq('0')
      expect(subject.current_gmt_offset).to eq('-7')
      expect(subject.time_zone_abbreviation).to eq('MST')
    end
  end

  describe '#==' do
    context 'with two objects that have the same attributes' do
      it 'returns true' do
        expect(subject).to eq(Accuweather::Conditions::Local.new(city: 'Winter Park',
                                                                 state: 'Colorado',
                                                                 lat: '39.89166',
                                                                 lon: '-105.7631',
                                                                 time: '21:14',
                                                                 time_zone: '-7',
                                                                 obs_daylight: '0',
                                                                 current_gmt_offset: '-7',
                                                                 time_zone_abbreviation: 'MST'))
      end
    end

    context 'with two objects that have that vary' do
      it 'returns false' do

      end
    end

    context 'with different objects' do
      it 'returns false' do
        expect(subject).to_not eq({})
      end
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the object' do
      expect(subject.to_s).to eq('city: Winter Park, state: Colorado, lat: 39.89166, lon: -105.7631, time: 21:14, time_zone: -7, obs_daylight: 0, current_gmt_offset: -7, time_zone_abbreviation: MST')
    end
  end
end