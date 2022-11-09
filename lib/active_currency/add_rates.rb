# frozen_string_literal: true

module ActiveCurrency
  # Store the latest currency rates.
  class AddRates
    include AfterCommitEverywhere

    def self.call(deprecated_currencies = nil, currencies: nil, bank: nil)
      currencies ||= deprecated_currencies
      bank ||= ActiveCurrency.remote_bank

      new(currencies: currencies, bank: bank).send(:call)
    end

    private

    def initialize(currencies:, bank:)
      if currencies.size < 2
        raise ArgumentError, 'At least two currencies are required'
      end

      @currencies = currencies.map(&:to_s).map(&:upcase)
      @bank = bank
    end

    private_class_method :new

    def call
      bank.update_rates

      in_transaction do
        rates_hash.each do |(from, to), rate|
          rate = multiply_rate(from, to, rate)
          store.add_rate(from, to, rate)
        end
      end

      nil
    end

    attr_accessor :bank, :currencies

    def store
      @store ||= ActiveCurrency::RateStore.new
    end

    def rates_hash
      currencies.each_with_object({}) do |from, hash|
        currencies.each do |to|
          next if from == to

          hash[[from, to]] = get_rate(hash, from, to)
        end
      end
    end

    def get_rate(hash, from, to)
      rate = bank.get_rate(from, to)
      return rate if rate

      # Inverse rate (not so good)
      inverse = hash[[to, from]]
      return 1.fdiv(inverse) if inverse

      # Rate going through the main currency (desperate)
      from_main = hash[[from, main_currency]]
      to_main = hash[[main_currency, to]]
      return from_main * to_main if from_main && to_main

      raise "Unknown rate between #{from} and #{to}"
    end

    def multiply_rate(from, to, rate)
      rate * ActiveCurrency.configuration.multiplier.fetch([from, to], 1)
    end

    def main_currency
      currencies.first
    end
  end
end
