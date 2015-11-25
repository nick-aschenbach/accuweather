require 'spec_helper'

describe Accuweather::Conditions::Current do
  subject { Accuweather::Conditions::Current.new(url: 'http://www.accuweather.com/m/en-us/US/CO/Winter Park/current.aspx?p=samsungmobile&amp;cityId=347805',
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
                                                 cloud_cover: '33%') }

  describe 'accessors' do
    it 'allows accessing the initialized attributes' do
      expect(subject.url).to eq('http://www.accuweather.com/m/en-us/US/CO/Winter Park/current.aspx?p=samsungmobile&amp;cityId=347805',)
      expect(subject.observation_time).to eq('9:14 PM',)
      expect(subject.pressure).to eq('30.12',)
      expect(subject.temperature).to eq('26',)
      expect(subject.real_feel).to eq('26',)
      expect(subject.humidity).to eq('44%',)
      expect(subject.weather_text).to eq('Partly cloudy',)
      expect(subject.weather_icon).to eq('35',)
      expect(subject.wind_gusts).to eq('11',)
      expect(subject.wind_speed).to eq('8',)
      expect(subject.wind_direction).to eq('SE',)
      expect(subject.visibility).to eq('8',)
      expect(subject.precip).to eq('0.00',)
      expect(subject.uv_index).to eq('Low',)
      expect(subject.dewpoint).to eq('7',)
      expect(subject.cloud_cover).to eq('33%')
    end
  end

  describe '#==' do
    context 'with two objects that have the same attributes' do
      it 'returns true' do
        expect(subject).to eq(Accuweather::Conditions::Current.new(url: 'http://www.accuweather.com/m/en-us/US/CO/Winter Park/current.aspx?p=samsungmobile&amp;cityId=347805',
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
    context 'with two objects that have that vary' do
      it 'returns false' do
        expect(subject).to_not eq(Accuweather::Conditions::Current.new(url: 'http://www.accuweather.com/m/en-us/US/CO/Winter Park/current.aspx?p=samsungmobile&amp;cityId=347805',
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
                                                                   visibility: 'DIFFERENT',
                                                                   precip: '0.00',
                                                                   uv_index: 'Low',
                                                                   dewpoint: '7',
                                                                   cloud_cover: '33%'))
      end
    end

    context 'with different objects' do
      it 'returns false' do
        expect(subject).to_not eq([])
      end
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the object' do
      expect(subject.to_s).to eq('url: http://www.accuweather.com/m/en-us/US/CO/Winter Park/current.aspx?p=samsungmobile&amp;cityId=347805, observation_time: 9:14 PM, pressure: 30.12, temperature: 26, real_feel: 26, humidity: 44%, weather_text: Partly cloudy, weather_icon: 35, wind_gusts: 11, wind_speed: 8, wind_direction: SE, visibility: 8, precip: 0.00, uv_index: Low, dewpoint: 7, cloud_cover: 33%')
    end
  end
end