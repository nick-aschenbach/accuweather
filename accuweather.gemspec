# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'accuweather/version'

Gem::Specification.new do |spec|
  spec.name          = 'accuweather'
  spec.version       = Accuweather::VERSION
  spec.authors       = ['Nick Aschenbach']
  spec.email         = ['nick.aschenbach@gmail.com']

  spec.summary       = 'Access current and future weather reports for cities around the world'
  spec.description   = 'Get weather information for cities around the world using the accuweather web API. Includes current current conditions for temperature, pressure and humidity. Forecasts include temperature highs, lows, "real feels", UV, wind speed, rain, snow, ice probabilities and amounts.'
  spec.homepage      = 'https://github.com/nick-aschenbach/accuweather'
  spec.licenses      = ['MIT']

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'

  spec.add_runtime_dependency 'nokogiri', '~> 1.6'
end
