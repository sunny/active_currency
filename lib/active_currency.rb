# frozen_string_literal: true

require 'money-rails'
require 'after_commit_everywhere'

require 'active_currency/configuration'
require 'active_currency/engine'
require 'active_currency/database_store'
require 'active_currency/cacheable_store'
require 'active_currency/rate_store'
require 'active_currency/add_rates'
require 'active_currency/bank'

module ActiveCurrency
  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def remote_bank
      case configuration.remote_bank
      when :eu_central_bank then eu_central_bank_instance
      when :open_exchange_rates then open_exchange_rates_instance
      end
    end

    private

    def eu_central_bank_instance
      require 'eu_central_bank'

      EuCentralBank.new
    end

    def open_exchange_rates_instance
      require 'money/bank/open_exchange_rates_bank'

      store = Money::RatesStore::Memory.new
      bank = Money::Bank::OpenExchangeRatesBank.new(store)
      bank.app_id = configuration.open_exchange_rates_app_id
      bank
    end
  end
end
