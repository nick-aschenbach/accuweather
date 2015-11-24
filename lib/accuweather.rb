require 'accuweather/version'
require 'accuweather/location'

require 'net/http'
require 'nokogiri'

module Accuweather
  def self.city_search(name)
    response = Net::HTTP.get('samsungmobile.accu-weather.com',
                             "/widget/samsungmobile/city-find.asp?returnGeoPosition=1&location=#{name}")


    xml = Nokogiri::XML.parse(response)
    xml.css('location').map do |location|
      Accuweather::Location.new(city: location.attr('city'),
                                state: location.attr('state'),
                                location: location.attr('location'),
                                latitude: location.attr('latitude'),
                                longitude: location.attr('longitude'))
    end
  rescue StandardError
    []
  end
end
