require 'spec_helper'

describe Accuweather::Conditions::ForecastWeather do
  subject { Accuweather::Conditions::ForecastWeather.new(weather_text: 'Partly sunny',
                                                         weather_text_long: 'Partly sunny with a chance of meatballs',
                                                         weather_icon: '03',
                                                         high_temperature: '44',
                                                         low_temperature: '11',
                                                         real_feel_high: '47',
                                                         real_feel_low: '3',
                                                         wind_speed: '5',
                                                         wind_direction: 'W',
                                                         wind_gust: '11',
                                                         max_uv: '3',
                                                         rain_amount: '0.01',
                                                         snow_amount: '0.2',
                                                         ice_amount: '0.03',
                                                         precipitation_amount: '0.04',
                                                         thunderstorm_probability: '5',
                                                         rain_probability: '6',
                                                         snow_probability: '7',
                                                         ice_probability: '8',
                                                         precipitation_probability: '9') }

  describe 'accessors' do
    it 'allows accessing the initialized attributes' do
      expect(subject.weather_text).to eq('Partly sunny')
      expect(subject.weather_text_long).to eq('Partly sunny with a chance of meatballs')
      expect(subject.weather_icon).to eq('03')
      expect(subject.high_temperature).to eq('44')
      expect(subject.low_temperature).to eq('11')
      expect(subject.real_feel_high).to eq('47')
      expect(subject.real_feel_low).to eq('3')
      expect(subject.wind_speed).to eq('5')
      expect(subject.wind_direction).to eq('W')
      expect(subject.wind_gust).to eq('11')
      expect(subject.max_uv).to eq('3')
      expect(subject.rain_amount).to eq('0.01')
      expect(subject.snow_amount).to eq('0.2')
      expect(subject.ice_amount).to eq('0.03')
      expect(subject.precipitation_amount).to eq('0.04')
      expect(subject.thunderstorm_probability).to eq('5')
      expect(subject.rain_probability).to eq('6')
      expect(subject.snow_probability).to eq('7')
      expect(subject.ice_probability).to eq('8')
      expect(subject.precipitation_probability).to eq('9')
    end
  end

  describe '#==' do
    context 'with two objects that have the same attributes' do
      it 'returns true' do
        expect(subject).to eq(Accuweather::Conditions::ForecastWeather.new(weather_text: 'Partly sunny',
                                                                           weather_text_long: 'Partly sunny with a chance of meatballs',
                                                                           weather_icon: '03',
                                                                           high_temperature: '44',
                                                                           low_temperature: '11',
                                                                           real_feel_high: '47',
                                                                           real_feel_low: '3',
                                                                           wind_speed: '5',
                                                                           wind_direction: 'W',
                                                                           wind_gust: '11',
                                                                           max_uv: '3',
                                                                           rain_amount: '0.01',
                                                                           snow_amount: '0.2',
                                                                           ice_amount: '0.03',
                                                                           precipitation_amount: '0.04',
                                                                           thunderstorm_probability: '5',
                                                                           rain_probability: '6',
                                                                           snow_probability: '7',
                                                                           ice_probability: '8',
                                                                           precipitation_probability: '9'))
      end
    end

    context 'with two objects that have that vary' do
      it 'returns false' do
        expect(subject).to_not eq(Accuweather::Conditions::ForecastWeather.new(weather_text: 'NOT Partly sunny',
                                                                               weather_text_long: 'Partly sunny with a chance of meatballs',
                                                                               weather_icon: '03',
                                                                               high_temperature: '44',
                                                                               low_temperature: '11',
                                                                               real_feel_high: '47',
                                                                               real_feel_low: '3',
                                                                               wind_speed: '5',
                                                                               wind_direction: 'W',
                                                                               wind_gust: '11',
                                                                               max_uv: '3',
                                                                               rain_amount: '0.01',
                                                                               snow_amount: '0.2',
                                                                               ice_amount: '0.03',
                                                                               precipitation_amount: '0.04',
                                                                               thunderstorm_probability: '5',
                                                                               rain_probability: '6',
                                                                               snow_probability: '7',
                                                                               ice_probability: '8',
                                                                               precipitation_probability: '9'))
      end
    end

    context 'with different objects' do
      it 'returns false' do
        expect(subject).to_not eq('')
      end
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the object' do
      expect(subject.to_s).to eq('weather_text: Partly sunny, weather_text_long: Partly sunny with a chance of meatballs, weather_icon: 03, high_temperature: 44, low_temperature: 11, real_feel_high: 47, real_feel_low: 3, wind_speed: 5, wind_direction: W, wind_gust: 11, max_uv: 3, rain_amount: 0.01, snow_amount: 0.2, ice_amount: 0.03, precipitation_amount: 0.04, thunderstorm_probability: 5, rain_probability: 6, snow_probability: 7, ice_probability: 8, precipitation_probability: 9')
    end
  end
end