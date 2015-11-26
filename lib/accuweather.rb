require 'accuweather/version'
require 'accuweather/location/city'
require 'accuweather/location/parser'
require 'accuweather/conditions/parser'
require 'accuweather/conditions/units'
require 'accuweather/conditions/local'
require 'accuweather/conditions/current'

require 'net/http'
require 'nokogiri'

module Accuweather
  def self.city_search(name)
    response = Net::HTTP.get('samsungmobile.accu-weather.com',
                             "/widget/samsungmobile/city-find.asp?returnGeoPosition=1&location=#{name}")

    Accuweather::Location::Parser.new(response).cities
  rescue StandardError
    []
  end

  def self.get_conditions(location_id)
    response = Net::HTTP.get('samsungmobile.accu-weather.com',
                             "/widget/samsungmobile/weather-data.asp?metric=0&location=#{location_id}")

    Accuweather::Conditions::Parser.new(response)
  rescue StandardError
    nil
  end
end
