# frozen_string_literal: true

module ActiveCurrency
  # Store the latest currency rates.
  class AddRates
    def initialize(currencies)
      @currencies = currencies
    end

    def call
      bank = EuCentralBank.new
      bank.update_rates

      from = 'EUR'
      currencies.map(&:to_s).each do |to|
        next if to == from

        rate = bank.get_rate(from, to)
        store.add_rate(from, to, rate)
        store.add_rate(to, from, 1 / rate)
      end
    end

    def self.call(currencies)
      new(currencies).call
    end

    private

    def currencies
      @currencies.map(&:to_s).map(&:upcase)
    end

    def store
      @store ||= ActiveCurrency::RateStore.new
    end
  end
end
