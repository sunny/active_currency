# ActiveCurrency

Rails plugin to retrieve and store the currency rates daily to integrate
with the `money-rails` gem.

## Rationale

Storing the current currency rates in the database using ActiveCurrency
provides the following advantages:

- Lets you find out what the currency rate you used in your application was
  at any given time.
- Does not need to call an API to get the rates when starting or restarting
  your web server.
- Choose how often you want to check for a currency (daily for example).
- Your users do not suffer the cost of making calls to the bank rates API.
- Your app does not go down when the bank rates API does.
- When fetching the current rate, it uses your application cache in order not
  to have to do a database query.

## Usage

Store the current rate regularly by calling in a scheduled job (using something
like `sidekiq-scheduler` or `whenever`):

```rb
ActiveCurrency::AddRates.new.call
```

You can then exchange money by using the Money gem:

```rb
10.to_money('EUR').exchange_to('USD').cents
```

Or look up the currency rate:

```rb
ActiveCurrency::Rate.current_value_for('EUR', 'USD', 10.days.ago)
# => 1.151
ActiveCurrency::Rate.where(from: 'EUR', to: 'USD').pluck(:value)
# => [1.162, 1.162, 1.161, 1.61, 1.63, …]
```

## Installation

Add these lines to your application's `Gemfile`:

```rb
# Store and retrieve the currency from the database.
gem 'active_currency',
    git: 'git@github.com:sunny/active_currency.git'
```

And in `config/initializers/money.rb`:

```rb
MoneyRails.configure do |config|
  rate_store = ActiveCurrency::RateStore.new(%w[EUR USD])
  config.default_bank = Money::Bank::VariableExchange.new(rate_store)
end
```

Then call `bundle exec rake db:migrate` to create the table that holds
the currency rates and fill it for the first time.

## Contributing

Please file issues and pull requests
[on GitHub](https://github.com/sunny/active_currency).

In developemnt, launch specs and code linter by calling:

```sh
bundle exec rake
```

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
