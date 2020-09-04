# Changelog

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning].

## Unreleased

Breaking change:
- Drop support for Rails < 4.2.

## v1.2.1

Fixed:

- Fix migrations export to host application

## v1.2.0

Features:

- Store all combination of rates between all currencies by defaulting to going
  through the first currency.
- `value_for` accepts any currency format accepted by `Money::Currency`.
- `value_for` returns `1` if asking for the same `from` and `to`.

## v1.1.0

Features:

- `ActiveCurrency::AddRates` accepts a custom `bank` argument.
- Use the first currency given to `AddRates` as the default currency instead of
  EUR.
- When given a custom bank, use its inverse rates if available.

## v1.0.2

Fix:

- Fix migrations under Rails 4.2.

## v1.0.1

Fix:

- Do not require the migration class while loading the app.

## v1.0.0

Nothing new, just released for the Paris.rb meetup! 🎉

## v0.5.0

Breaking change:

- Remove `ActiveCurrency::MemoryRateStore` prefer `Money::RatesStore::Memory`.

Features:

- Add `ActiveCurrency::Bank` to simplify app's initializer.
- Add `.call` to `ActiveCurrency::AddRates` to simplify app's calls.

Fix:

- Remove migration that adds rates automatically.

## v0.4.0

Fix:

- Allow adding rates without setting the default store.

## v0.3.0

Breaking changes:

- Move the list of currencies to AddRate.
- Remove `current_value_for` that was deprecated in v0.2.0.
- Add eu_central_bank dependency condition.

Fix:

- Allow lowercase currencies when adding rates.

## v0.2.0

Features:

- Support for Rails 3.2.
- Prefer `value_for` to `current_value_for`.
- Add a `ActiveCurrency::MemoryRateStore`, useful in test mode.

## v0.1.0

- First Release \o/

[Semantic Versioning]: https://semver.org/spec/v2.0.0.html
