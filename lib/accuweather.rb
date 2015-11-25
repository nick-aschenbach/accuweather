require 'accuweather/version'
require 'accuweather/location'
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


    xml = Nokogiri::XML.parse(response)
    xml.css('location').map do |location|
      Accuweather::Location.new(id: location.attr('location'),
                                city: location.attr('city'),
                                state: location.attr('state'),
                                latitude: location.attr('latitude'),
                                longitude: location.attr('longitude'))
    end
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
