# ActiveCurrency

[![CircleCI](https://circleci.com/gh/sunny/active_currency.svg?style=svg)](https://circleci.com/gh/sunny/active_currency)

Rails plugin to retrieve and store the currency rates daily to integrate
with the `money-rails` gem.

## Rationale

Storing the current currency rates in the database using ActiveCurrency
provides the following advantages:

- Lets you query for the currency rate you actually used in your application at
  any given time.
- Does not need to call an API to get the rates when starting or restarting
  your web server.
- Does not depend on the file system to store cached rates.
- Choose how often you want to update the currency rates (daily for example).
- Your users do not suffer the cost of making calls to the bank rates API.
- Your app does not go down when the bank rates API does.

To fetch the *current* rate it uses your application cache instead of making
a call to the database.

## Usage

Store the current rate regularly by calling in a scheduled job (using something
like `sidekiq-scheduler`, `whenever`, or `active_scheduler`) with the currencies
you want to store:

```rb
ActiveCurrency::AddRates.call(%w[EUR USD])
```

You can then exchange money by using the Money gem helpers:

```rb
10.to_money('EUR').exchange_to('USD').cents
```

If you need to look up the previous currency rates:

```rb
ActiveCurrency::Rate.value_for('EUR', 'USD', 1.month.ago)
# => 1.151
ActiveCurrency::Rate.where(from: 'EUR', to: 'USD').pluck(:value)
# => [1.162, 1.162, 1.161, 1.161, 1.163, …]
```

## Installation

Add these lines to your application's `Gemfile`:

```rb
# Store and retrieve the currency from the database.
gem 'active_currency'
```

And in `config/initializers/money.rb`:

```rb
MoneyRails.configure do |config|
  config.default_bank = ActiveCurrency::Bank.new
end
```

Then call `bin/rake db:migrate` to create the table that holds
the currency rates and fill it for the first time.

## Fetching rates

By defaut it uses the [eu_central_bank] to update the currency rates.

If you prefer another API, you can provide any Money-compatible bank when
calling `ActiveCurrency::AddRates`. For example with the
[money-open-exchange-rates] gem:

```rb
require 'money/bank/open_exchange_rates_bank'

bank = Money::Bank::OpenExchangeRatesBank.new(Money::RatesStore::Memory.new)
bank.app_id = '…'

ActiveCurrency::AddRates.call(%w[EUR USD], bank: bank)
```

The first currency you give to `AddRates` is considered the default currency
against which other currency rates will be saved.

## Tests

In your app test suite you may not want to have to fill your database to be
able to exchange currencies.

For that, you can use a fake rate store in your `rails_helper.rb`:

```rb
MoneyRails.configure do |config|
  rate_store = Money::RatesStore::Memory.new.tap do |store|
    store.add_rate('USD', 'EUR', 1.5)
    store.add_rate('EUR', 'USD', 1.4)
  end
  config.default_bank = Money::Bank::VariableExchange.new(rate_store)
end
```

## Contributing

Please file issues and pull requests
[on GitHub](https://github.com/sunny/active_currency).

## Development

Install:

```sh
BUNDLE_GEMFILE=Gemfile-rails6.0 bundle install
```

Launch specs and linters:

```sh
BUNDLE_GEMFILE=Gemfile-rails6.0 bin/rake
```

## Release

Update `CHANGELOG.md`, update version in `lib/active_currency/version.rb`.

Then:

```sh
gem install bundler:1.17.2
BUNDLE_GEMFILE=Gemfile-rails3.2 bundle update active_currency
BUNDLE_GEMFILE=Gemfile-rails4.2 bundle update active_currency

gem install bundler:2.1.2
BUNDLE_GEMFILE=Gemfile-rails5.2 bundle update active_currency
BUNDLE_GEMFILE=Gemfile-rails6.0 bundle update active_currency

git add CHANGELOG.md lib/active_currency/version.rb Gemfile-rails*.lock
git commit -m v`ruby -r./lib/active_currency/version <<< 'puts ActiveCurrency::VERSION'`
bin/rake release
```

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

[eu_central_bank]: https://github.com/RubyMoney/eu_central_bank
[money-open-exchange-rates]: https://github.com/spk/money-open-exchange-rates
