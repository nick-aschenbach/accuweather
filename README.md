# Accuweather

A simple wrapper around the accuweather web API written in Ruby

Get weather information for cities around the world. Includes current current conditions for temperature, pressure and humidity. Forecasts include temperature highs, lows, "real feels", UV, wind speed and direction, rain, snow, ice probabilities and amounts. The web API returns seven days of forecasts with estimates for both day and nighttime.

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

Search for a city location to determine its id:

```ruby
location_array = Accuweather.city_search(name: 'vancouver')
vancouver = location_array.first

vancouver.id        # => 'cityId:53286'
vancouver.city      # => 'Vancouver'
vancouver.state     # => 'Canada (British Columbia)'
vancouver.latitude  # => '49.2448'
vancouver.longitude # => '123.1154'
```

Search for weather conditions for a given location id:

```ruby
current_weather = Accuweather.get_conditions(location_id: 'cityId:53286').current
current_weather.temperature    # => '41'
current_weather.weather_text   # => 'Partly Sunny'
current_weather.pressure       # => '30.35'
current_weather.humidity       # => '43%'
current_weather.cloud_cover    # => '40%'
```

Get forecast details:

```ruby
weather_forecast = Accuweather.get_conditions(location_id: 'cityId:53286').forecast
last_forecast_day = weather_forecast.last
last_forecast_day.date        # => "12/3/2015"
last_forecast_day.day_of_week # => "Thursday"
last_forecast_day.sunrise     # => "7:49 AM"
last_forecast_day.sunset      # => "4:16 PM"

# Get the dates, daytime high and nighttime low temperatures
weather_forecast.map(&:date)                             #  => ["11/27/2015", "11/28/2015", "11/29/2015", "11/30/2015", "12/1/2015", "12/2/2015", "12/3/2015"]
weather_forecast.map(&:daytime).map(&:high_temperature)  # => ["45", "45", "47", "44", "44", "48", "48"]
weather_forecast.map(&:nighttime).map(&:low_temperature) # => ["27", "28", "31", "32", "40", "42", "36"]
```

See `Accuview::Conditions::ForecastWeather` class for a full list of attributes for daytime and nighttime forecasts.

Get the units for the conditions:

```ruby
units = Accuweather.get_conditions(location_id: 'cityId:53286').units
units.temperature  # => 'F'
units.distance     # => 'MI'
units.speed        # => 'MPH'
```

Get more information on the location including time and time zone:

```ruby
local = Accuweather.get_conditions(location_id: 'cityId:53286').local
local.time                   # => '13:41'
local.time_zone              # => '-8'
local.time_zone_abbreviation # => 'PST'
```

English units are returned by default, but metric results are available:

```ruby
Accuweather.get_conditions(location_id: 'cityId:53286', metric: true)
```

Each `Accuweather::Conditions` object implements a `to_s` method that displays all attribute
name, value pairs. This makes it easy to explore the API. For example:

```ruby
Accuweather.get_conditions(location_id: 'cityId:53286').local.to_s
# => "city: Vancouver, state: British Columbia, latitude: 49.2448, longitude: -123.1154, time: 16:58, time_zone: -8, obs_daylight: 0, current_gmt_offset: -8, time_zone_abbreviation: PST"
```

## Development

Run `rake` to run the tests

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/accuweather.

