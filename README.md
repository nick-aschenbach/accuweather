# Accuweather

Get weather information for cities around the world using the accuweather API

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
Accuweather.get_conditions('cityId:53286').current
```

Get the units for the conditions:

```ruby
Accuweather.get_conditions('cityId:53286').units
```

Get more information on the location including time, time zone and GPS coordinates:

```ruby
Accuweather.get_conditions('cityId:53286').local
```

## Development

Run `rake` to run the tests

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/accuweather.

