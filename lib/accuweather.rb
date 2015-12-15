require 'accuweather/version'
require 'accuweather/location/city'
require 'accuweather/location/cache'
require 'accuweather/location/parser'
require 'accuweather/conditions/parser'
require 'accuweather/conditions/units'
require 'accuweather/conditions/local'
require 'accuweather/conditions/planets'
require 'accuweather/conditions/current'
require 'accuweather/conditions/forecast_day'
require 'accuweather/conditions/forecast_weather'

require 'net/http'
require 'nokogiri'

module Accuweather
  class Error < StandardError; end

  def self.city_search(name:)
    @cache ||= Accuweather::Location::Cache.new
    cache_result = @cache.cities(name: name)
    return cache_result unless cache_result == []

    response = Net::HTTP.get('samsungmobile.accu-weather.com',
                             "/widget/samsungmobile/city-find.asp?returnGeoPosition=1&location=#{name}")

    Accuweather::Location::Parser.new(response).cities
  rescue StandardError => e
    raise Accuweather::Error.new("#{e.class}: #{e.message}")
  end

  def self.get_conditions(location_id:, metric: false)
    metric_value = metric ? '1' : '0'
    response = Net::HTTP.get('samsungmobile.accu-weather.com',
                             "/widget/samsungmobile/weather-data.asp?metric=#{metric_value}&location=#{location_id}")

    Accuweather::Conditions::Parser.new(response)
  rescue StandardError => e
    raise Accuweather::Error.new("#{e.class}: #{e.message}")
  end
end
