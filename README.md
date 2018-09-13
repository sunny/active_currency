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
Add this line to your application's Gemfile:

```rb
gem 'active_currency'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install active_currency
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
