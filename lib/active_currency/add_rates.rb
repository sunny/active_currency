# frozen_string_literal: true

module ActiveCurrency
  # Store the latest currency rates.
  class AddRates
    def initialize(currencies, bank: EuCentralBank.new)
      @currencies = currencies
      @bank = bank
    end

    def call
      bank.update_rates

      other_currencies.each do |to|
        store_rate(to)
      end

      nil
    end

    def self.call(currencies, *options)
      new(currencies, *options).call
    end

    private

    attr_accessor :bank

    def currencies
      @currencies.map(&:to_s).map(&:upcase)
    end

    def other_currencies
      currencies.drop(1)
    end

    def from
      @from ||= currencies.first
    end

    def store
      @store ||= ActiveCurrency::RateStore.new
    end

    def store_rate(to)
      rate, inverse = get_rate_and_inverse(to)

      store.add_rate(from, to, rate)
      store.add_rate(to, from, inverse)
    end

    def get_rate_and_inverse(to)
      rate = bank.get_rate(from, to)
      raise "Unknown rate between #{from} and #{to}" if rate.nil? || rate.zero?

      inverse = bank.get_rate(to, from) || 1.fdiv(rate)

      [rate, inverse]
    end
  end
end
