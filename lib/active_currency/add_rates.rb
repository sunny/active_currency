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
        Money.add_rate(from, to, rate)
        Money.add_rate(to, from, 1 / rate)
      end
    end

    private

    def currencies
      @currencies.map(&:to_s).map(&:upcase)
    end
  end
end
