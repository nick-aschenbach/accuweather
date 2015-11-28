require 'spec_helper'

describe Accuweather::Conditions::ForecastDay do
  subject { Accuweather::Conditions::ForecastDay.new(date: '11/23/2015',
                                                     day_of_week: 'Monday',
                                                     sunrise: '6:57 AM',
                                                     sunset: '4:42 PM',
                                                     daytime: 'day forecast weather',
                                                     nighttime: 'night forecast weather') }

  describe 'accessors' do
    it 'allows accessing the initialized attributes' do
      expect(subject.date).to eq('11/23/2015')
      expect(subject.day_of_week).to eq('Monday')
      expect(subject.sunrise).to eq('6:57 AM')
      expect(subject.sunset).to eq('4:42 PM')
    end
  end

  describe '#==' do
    context 'with two objects that have the same attributes' do
      it 'returns true' do
        expect(subject).to eq(Accuweather::Conditions::ForecastDay.new(date: '11/23/2015',
                                                                       day_of_week: 'Monday',
                                                                       sunrise: '6:57 AM',
                                                                       sunset: '4:42 PM',
                                                                       daytime: 'day forecast weather',
                                                                       nighttime: 'night forecast weather'))
      end
    end

    context 'with two objects that have that vary' do
      it 'returns false' do
        expect(subject).to_not eq(Accuweather::Conditions::ForecastDay.new(date: '11/23/2015',
                                                                           day_of_week: 'NOT MONDAY',
                                                                           sunrise: '6:57 AM',
                                                                           sunset: '4:42 PM',
                                                                           daytime: 'day forecast weather',
                                                                           nighttime: 'night forecast weather'))
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
      expect(subject.to_s).to eq('date: 11/23/2015, day_of_week: Monday, sunrise: 6:57 AM, sunset: 4:42 PM, daytime: day forecast weather, nighttime: night forecast weather')
    end
  end
end