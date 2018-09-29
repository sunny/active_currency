# frozen_string_literal: true

MoneyRails.configure do |config|
  config.default_bank = ActiveCurrency::Bank.new
end
