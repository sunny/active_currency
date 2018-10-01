# Changelog

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning].

## Unreleased

## v0.5.0

Breaking change:
- Remove `ActiveCurrency::MemoryRateStore` prefer `Money::RatesStore::Memory`.

Feature:
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
