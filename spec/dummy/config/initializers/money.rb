# frozen_string_literal: true

MoneyRails.configure do |config|
  config.default_bank =
    Money::Bank::VariableExchange.new(ActiveCurrency::RateStore.new)
end
