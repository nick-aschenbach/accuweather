require 'spec_helper'

describe Accuweather::Conditions::Units do
  subject { Accuweather::Conditions::Units.new(temp: 'F',
                                               dist: 'MI',
                                               speed: 'MPH',
                                               pres: 'IN',
                                               prec: 'IN') }

  describe 'accessors' do
    it 'allows accessing the initialized attributes' do
      expect(subject.temp).to eq('F')
      expect(subject.dist).to eq('MI')
      expect(subject.speed).to eq('MPH')
      expect(subject.pres).to eq('IN')
      expect(subject.prec).to eq('IN')
    end
  end

  describe '#==' do
    context 'with two objects that have the same attributes' do
      it 'returns true' do
        expect(subject).to eq(Accuweather::Conditions::Units.new(temp: 'F',
                                                                 dist: 'MI',
                                                                 speed: 'MPH',
                                                                 pres: 'IN',
                                                                 prec: 'IN'))
      end
    end
    context 'with two objects that have that vary' do
      it 'returns false' do
        expect(subject).to_not eq(Accuweather::Conditions::Units.new(temp: 'C',
                                                                     dist: 'MI',
                                                                     speed: 'MPH',
                                                                     pres: 'IN',
                                                                     prec: 'IN'))
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
      expect(subject.to_s).to eq('temp: F, dist: MI, speed: MPH, pres: IN, prec: IN')
    end
  end
end