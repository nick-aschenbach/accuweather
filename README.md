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

```ruby
Accuweather.city_search('vancouver')
```

Returns a list of `Accuweather::Location`s. Each location has a `city`, `state`, `location`, `latitude` and `longitude`.

## Development

Run `rake` to run the tests

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/accuweather.

