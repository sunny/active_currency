MoneyRails.configure do |config|
  rate_store = ActiveCurrency::RateStore.new(%w[EUR USD])
  config.default_bank = Money::Bank::VariableExchange.new(rate_store)
end
