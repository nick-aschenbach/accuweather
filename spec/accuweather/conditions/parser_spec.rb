require 'spec_helper'

describe Accuweather::Conditions::Parser do
  let(:fixture) { load_fixture('get-conditions.xml') }
  subject { described_class.new(fixture) }

  describe '#units' do
    it 'has expected units' do
      expect(subject.units).to eq(Accuweather::Conditions::Units.new(temperature: 'F',
                                                                     distance: 'MI',
                                                                     speed: 'MPH',
                                                                     pressure: 'IN',
                                                                     precipitation: 'IN'))
    end
  end

  describe '#local' do
    it 'has expected local data' do
      expect(subject.local).to eq(Accuweather::Conditions::Local.new(city: 'Winter Park',
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

  describe '#current' do
    it 'has expected current conditions' do
      expect(subject.current).to eq(Accuweather::Conditions::Current.new(url: 'http://www.accuweather.com/m/en-us/US/CO/Winter Park/current.aspx?p=samsungmobile&cityId=347805',
                                                                         observation_time: '9:14 PM',
                                                                         pressure: '30.12',
                                                                         temperature: '26',
                                                                         real_feel: '26',
                                                                         humidity: '44%',
                                                                         weather_text: 'Partly cloudy',
                                                                         weather_icon: '35',
                                                                         wind_gusts: '11',
                                                                         wind_speed: '8',
                                                                         wind_direction: 'SE',
                                                                         visibility: '8',
                                                                         precip: '0.00',
                                                                         uv_index: 'Low',
                                                                         dewpoint: '7',
                                                                         cloud_cover: '33%'))
    end
  end
end