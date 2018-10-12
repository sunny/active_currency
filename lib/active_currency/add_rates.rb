# frozen_string_literal: true

module ActiveCurrency
  # Store the latest currency rates.
  class AddRates
    def initialize(currencies)
      @currencies = currencies
    end

    def call
      other_currencies.each do |to|
        store_rate(from, to)
      end
    end

    def self.call(currencies)
      new(currencies).call
    end

    private

    def currencies
      @currencies.map(&:to_s).map(&:upcase)
    end

    def other_currencies
      currencies - [from]
    end

    def from
      'EUR'
    end

    def store
      @store ||= ActiveCurrency::RateStore.new
    end

    def bank
      @bank ||= EuCentralBank.new.tap(&:update_rates)
    end

    def store_rate(from, to)
      rate = bank.get_rate(from, to)

      if rate.nil? || rate.zero?
        raise "Bank rate must be set but bank returned #{rate.inpsect}"
      end

      store.add_rate(from, to, rate)
      store.add_rate(to, from, 1.fdiv(rate))
    end
  end
end
