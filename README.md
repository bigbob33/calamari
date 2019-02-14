# Calamari

A Calamari API Ruby client

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'calamari'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install calamari

## Usage

Initialize the client

```
require './lib/calamari'

client = Calamari::Client.new(
  domain: ENV['CALAMARI_DOMAIN'],
  api_key: ENV['CALAMARI_API_KEY'],
  api_user: ENV['CALAMARI_USER']
)
```

then use one of the available methods:

```
client.absence_requests_find(
  employee: '<EMPLOYEE_ID',
  from: '2019-01-01',
  to: '2019-03-01'
)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/themasters/calamari-client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
