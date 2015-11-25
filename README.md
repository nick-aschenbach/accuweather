# Accuweather

Get weather information for cities around the world using the accuweather API. Includes
temperature, pressure, humidity, weather text and GPS coordinates.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'accuweather'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install accuweather

## Usage

Search for an accuweather location:

```ruby
location_array = Accuweather.city_search('vancouver') # returns an array
vancouver = location_array.first

vancouver.id        # => 'cityId:53286'
vancouver.city      # => 'Vancouver'
vancouver.state     # => 'Canada (British Columbia)'
vancouver.latitude  # => '49.2448'
vancouver.longitude # => '123.1154'
```

Search for weather conditions for a given location id:

```ruby
current_weather = Accuweather.get_conditions('cityId:53286').current
current_weather.temperature    # => '41'
current_weather.weather_text   # => 'Partly Sunny'
current_weather.pressure       # => '30.35'
current_weather.humidity       # => '43%'
current_weather.cloud_cover    # => '40%'
```

Get the units for the conditions:

```ruby
units = Accuweather.get_conditions('cityId:53286').units
units.temperature  # => 'F'
units.distance     # => 'MI'
units.speed        # => 'MPH'
```

Get more information on the location including time and time zone:

```ruby
local = Accuweather.get_conditions('cityId:53286').local
local.time                   # => '13:41'
local.time_zone              # => '-8'
local.time_zone_abbreviation # => 'PST'
```

Each `Accuweather::Conditions` object implements a `to_s` method that displays all attribute
name, value pairs. This makes it easy to explore the API. For example:

```ruby
Accuweather.get_conditions('cityId:53286').local.to_s
# => "city: Vancouver, state: British Columbia, lat: 49.2448, lon: -123.1154, time: 13:41, time_zone: -8, obs_daylight: 0, current_gmt_offset: -8, time_zone_abbreviation: PST"
```

## Development

Run `rake` to run the tests

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/accuweather.

