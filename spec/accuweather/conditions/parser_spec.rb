require 'spec_helper'

describe Accuweather::Conditions::Parser do
  let(:fixture) { load_fixture('get-conditions.xml') }
  subject { described_class.new(fixture) }

  describe '#units' do
    it 'returns expected units' do
      expect(subject.units).to eq(Accuweather::Conditions::Units.new(temperature: 'F',
                                                                     distance: 'MI',
                                                                     speed: 'MPH',
                                                                     pressure: 'IN',
                                                                     precipitation: 'IN'))
    end
  end

  describe '#local' do
    it 'returns expected local data' do
      expect(subject.local).to eq(Accuweather::Conditions::Local.new(city: 'Winter Park',
                                                                     state: 'Colorado',
                                                                     latitude: '39.89166',
                                                                     longitude: '-105.7631',
                                                                     time: '21:14',
                                                                     time_zone: '-7',
                                                                     obs_daylight: '0',
                                                                     current_gmt_offset: '-7',
                                                                     time_zone_abbreviation: 'MST'))
    end
  end

  describe '#current' do
    it 'returns expected current conditions' do
      expect(subject.current).to eq(Accuweather::Conditions::Current.new(observation_time: '9:14 PM',
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
                                                                         precipitation: '0.00',
                                                                         uv_index: 'Low',
                                                                         dewpoint: '7',
                                                                         cloud_cover: '33%'))
    end
  end

  describe '#forecast' do
    it 'returns expected first day forecast' do
      day = Accuweather::Conditions::ForecastWeather.new(weather_text: 'Partly sunny',
                                                         weather_text_long: 'Partly sunny',
                                                         weather_icon: '03',
                                                         high_temperature: '44',
                                                         low_temperature: '11',
                                                         real_feel_high: '47',
                                                         real_feel_low: '3',
                                                         wind_speed: '5',
                                                         wind_direction: 'W',
                                                         wind_gust: '11',
                                                         max_uv: '3',
                                                         rain_amount: '0.00',
                                                         snow_amount: '0.0',
                                                         ice_amount: '0.00',
                                                         precipitation_amount: '0.00',
                                                         thunderstorm_probability: '0',
                                                         rain_probability: '0',
                                                         snow_probability: '0',
                                                         ice_probability: '0',
                                                         precipitation_probability: '0')

      night = Accuweather::Conditions::ForecastWeather.new(weather_text: 'Mainly clear',
                                                           weather_text_long: 'Mainly clear',
                                                           weather_icon: '34',
                                                           high_temperature: '44',
                                                           low_temperature: '11',
                                                           real_feel_high: '30',
                                                           real_feel_low: '13',
                                                           wind_speed: '3',
                                                           wind_direction: 'W',
                                                           wind_gust: '7',
                                                           max_uv: '3',
                                                           rain_amount: '0.00',
                                                           snow_amount: '0.0',
                                                           ice_amount: '0.00',
                                                           precipitation_amount: '0.00',
                                                           thunderstorm_probability: '0',
                                                           rain_probability: '0',
                                                           snow_probability: '0',
                                                           ice_probability: '0',
                                                           precipitation_probability: '0')


      expect(subject.forecast.first).to eq(Accuweather::Conditions::ForecastDay.new(date: '11/23/2015',
                                                                                    day_of_week: 'Monday',
                                                                                    sunrise: '6:57 AM',
                                                                                    sunset: '4:42 PM',
                                                                                    daytime: day,
                                                                                    nighttime: night))
    end

    it 'returns expected last day forecast' do
      day = Accuweather::Conditions::ForecastWeather.new(weather_text: 'Mostly cloudy',
                                                         weather_text_long: 'Mostly cloudy with a stray flurry in the afternoon',
                                                         weather_icon: '07',
                                                         high_temperature: '34',
                                                         low_temperature: '17',
                                                         real_feel_high: '27',
                                                         real_feel_low: '18',
                                                         wind_speed: '7',
                                                         wind_direction: 'WNW',
                                                         wind_gust: '11',
                                                         max_uv: '2',
                                                         rain_amount: '0.10',
                                                         snow_amount: '0.7',
                                                         ice_amount: '0.20',
                                                         precipitation_amount: '0.07',
                                                         thunderstorm_probability: '0',
                                                         rain_probability: '0',
                                                         snow_probability: '45',
                                                         ice_probability: '10',
                                                         precipitation_probability: '45')

      night = Accuweather::Conditions::ForecastWeather.new(weather_text: 'Colder with a bit of snow',
                                                           weather_text_long: 'Mostly cloudy and colder with a bit of snow',
                                                           weather_icon: '19',
                                                           high_temperature: '34',
                                                           low_temperature: '17',
                                                           real_feel_high: '19',
                                                           real_feel_low: '7',
                                                           wind_speed: '6',
                                                           wind_direction: 'WNW',
                                                           wind_gust: '11',
                                                           max_uv: '2',
                                                           rain_amount: '0.00',
                                                           snow_amount: '0.2',
                                                           ice_amount: '0.00',
                                                           precipitation_amount: '0.01',
                                                           thunderstorm_probability: '0',
                                                           rain_probability: '0',
                                                           snow_probability: '47',
                                                           ice_probability: '0',
                                                           precipitation_probability: '56')


      expect(subject.forecast.last).to eq(Accuweather::Conditions::ForecastDay.new(date: '11/29/2015',
                                                                                   day_of_week: 'Sunday',
                                                                                   sunrise: '7:03 AM',
                                                                                   sunset: '4:39 PM',
                                                                                   daytime: day,
                                                                                   nighttime: night))
    end
  end
end