# ActiveCurrency

Rails plugin to retrieve and store the currency daily.

Integrates with the `money-rails` gem.

## Usage

Store the current rate regularly by calling in a scheduled job:

```rb
ActiveCurrency::AddRates.call
```

Retrieve the current rate by using `Money`'s accessors:

```rb
10.to_money('EUR').exchange_to('USD').cents
```

Or by looking through the database:

```rb
ActiveCurrency::Rate.current_value_for('EUR', 'USD', 10.days.ago)
# => 1.162
```

## Installation

Add these lines to your application's `Gemfile`:

```rb
# Store and retrieve the currency from the database.
gem 'active_currency',
    git: 'git@github.com:sunny/active_currency.git'
```

And in your `config/initializers/money.rb`:

```rb
MoneyRails.configure do |config|
  rate_store = ActiveCurrency::RateStore.new(%w[EUR USD])
  config.default_bank = Money::Bank::VariableExchange.new(rate_store)
end
```


## Contributing

Please file issues and pull requests on GitHub.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).s
