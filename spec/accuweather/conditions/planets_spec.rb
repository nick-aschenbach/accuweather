require 'spec_helper'

describe Accuweather::Conditions::Planets do
  subject { Accuweather::Conditions::Planets.new(sunrise: '6:57 AM',
                                                 sunset: '4:42 PM',
                                                 moonrise: '11/23/2015 3:30:00 PM',
                                                 moonset: '11/24/2015 5:15:00 AM',
                                                 mercuryrise: '2:14 PM',
                                                 mercuryset: '11:48 PM',
                                                 venusrise: '10:09 AM',
                                                 venusset: '9:46 PM',
                                                 marsrise: '9:21 AM',
                                                 marsset: '9:20 PM',
                                                 jupiterrise: '8:01 AM',
                                                 jupiterset: '8:41 PM',
                                                 saturnrise: '2:22 PM',
                                                 saturnset: '12:10 AM',
                                                 uranusrise: '9:36 PM',
                                                 uranusset: '10:23 AM',
                                                 neptunerise: '8:01 PM',
                                                 neptuneset: '7:03 AM',
                                                 plutorise: '5:06 PM',
                                                 plutoset: '2:44 AM') }

  describe 'accessors' do
    it 'allows accessing the initialized attributes' do
      expect(subject.sunrise).to eq('6:57 AM')
      expect(subject.sunset).to eq('4:42 PM')
      expect(subject.moonrise).to eq('11/23/2015 3:30:00 PM')
      expect(subject.moonset).to eq('11/24/2015 5:15:00 AM')
      expect(subject.mercuryrise).to eq('2:14 PM')
      expect(subject.mercuryset).to eq('11:48 PM')
      expect(subject.venusrise).to eq('10:09 AM')
      expect(subject.venusset).to eq('9:46 PM')
      expect(subject.marsrise).to eq('9:21 AM')
      expect(subject.marsset).to eq('9:20 PM')
      expect(subject.jupiterrise).to eq('8:01 AM')
      expect(subject.jupiterset).to eq('8:41 PM')
      expect(subject.saturnrise).to eq('2:22 PM')
      expect(subject.saturnset).to eq('12:10 AM')
      expect(subject.uranusrise).to eq('9:36 PM')
      expect(subject.uranusset).to eq('10:23 AM')
      expect(subject.neptunerise).to eq('8:01 PM')
      expect(subject.neptuneset).to eq('7:03 AM')
      expect(subject.plutorise).to eq('5:06 PM')
      expect(subject.plutoset).to eq('2:44 AM')
    end
  end

  describe '#==' do
    context 'with two objects that have the same attributes' do
      it 'returns true' do
        expect(subject).to eq(Accuweather::Conditions::Planets.new(sunrise: '6:57 AM',
                                                                   sunset: '4:42 PM',
                                                                   moonrise: '11/23/2015 3:30:00 PM',
                                                                   moonset: '11/24/2015 5:15:00 AM',
                                                                   mercuryrise: '2:14 PM',
                                                                   mercuryset: '11:48 PM',
                                                                   venusrise: '10:09 AM',
                                                                   venusset: '9:46 PM',
                                                                   marsrise: '9:21 AM',
                                                                   marsset: '9:20 PM',
                                                                   jupiterrise: '8:01 AM',
                                                                   jupiterset: '8:41 PM',
                                                                   saturnrise: '2:22 PM',
                                                                   saturnset: '12:10 AM',
                                                                   uranusrise: '9:36 PM',
                                                                   uranusset: '10:23 AM',
                                                                   neptunerise: '8:01 PM',
                                                                   neptuneset: '7:03 AM',
                                                                   plutorise: '5:06 PM',
                                                                   plutoset: '2:44 AM'))
      end
    end

    context 'with two objects that have that vary' do
      it 'returns false' do
        expect(subject).to_not eq(Accuweather::Conditions::Planets.new(sunrise: 'X:XX PM',
                                                                       sunset: '4:42 PM',
                                                                       moonrise: '11/23/2015 3:30:00 PM',
                                                                       moonset: '11/24/2015 5:15:00 AM',
                                                                       mercuryrise: '2:14 PM',
                                                                       mercuryset: '11:48 PM',
                                                                       venusrise: '10:09 AM',
                                                                       venusset: '9:46 PM',
                                                                       marsrise: '9:21 AM',
                                                                       marsset: '9:20 PM',
                                                                       jupiterrise: '8:01 AM',
                                                                       jupiterset: '8:41 PM',
                                                                       saturnrise: '2:22 PM',
                                                                       saturnset: '12:10 AM',
                                                                       uranusrise: '9:36 PM',
                                                                       uranusset: '10:23 AM',
                                                                       neptunerise: '8:01 PM',
                                                                       neptuneset: '7:03 AM',
                                                                       plutorise: '5:06 PM',
                                                                       plutoset: '2:44 AM'))
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
      expect(subject.to_s).to eq('sunrise: 6:57 AM, sunset: 4:42 PM, moonrise: 11/23/2015 3:30:00 PM, moonset: 11/24/2015 5:15:00 AM, mercuryrise: 2:14 PM, mercuryset: 11:48 PM, venusrise: 10:09 AM, venusset: 9:46 PM, marsrise: 9:21 AM, marsset: 9:20 PM, jupiterrise: 8:01 AM, jupiterset: 8:41 PM, saturnrise: 2:22 PM, saturnset: 12:10 AM, uranusrise: 9:36 PM, uranusset: 10:23 AM, neptunerise: 8:01 PM, neptuneset: 7:03 AM, plutorise: 5:06 PM, plutoset: 2:44 AM')
    end
  end
end