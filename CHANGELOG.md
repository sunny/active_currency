# Changelog

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning].

## Unreleased

Breaking changes:
- Move the list of currencies to AddRate.
- Remove `current_value_for` that was deprecated in v0.2.0.
- Add eu_central_bank dependency condition.

## v0.2.0

Features:
- Support for Rails 3.2.
- Prefer `value_for` to `current_value_for`.
- Add a `ActiveCurrency::MemoryRateStore`, useful in test mode.

## v0.1.0

- First Release \o/

[Semantic Versioning]: https://semver.org/spec/v2.0.0.html
