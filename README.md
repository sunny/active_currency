# ActiveCurrency

Rails plugin to retrieve and store the currency daily.

Integrates with the `money-rails` gem.

## Usage

```rb
MoneyRails.configure do |config|
  rate_store = ActiveCurrency::RateStore.new(%w[EUR USD]
  config.default_bank = Money::Bank::VariableExchange.new(rate_store)
end

```

## Installation

Add these lines to your application's Gemfile:

```rb
# Store and retrieve the currency from the database.
gem 'active_currency'
```


## Contributing

Please file issues and pull requests on GitHub.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).s
