# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'accuweather/version'

Gem::Specification.new do |spec|
  spec.name          = 'accuweather'
  spec.version       = Accuweather::VERSION
  spec.authors       = ['Nick Aschenbach']
  spec.email         = ['nick.aschenbach@gmail.com']

  spec.summary       = 'Access current weather report for cities around the world'
  spec.description   = 'A simple web API wrapper to get weather information for cities around the world using the accuweather API. Includes
temperature, pressure, humidity, weather text and GPS coordinates.'
  spec.homepage      = 'https://github.com/nick-aschenbach/accuweather'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'

  spec.add_runtime_dependency 'nokogiri'
end
