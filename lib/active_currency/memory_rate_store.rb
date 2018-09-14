# frozen_string_literal: true

module ActiveCurrency
  class MemoryRateStore < Money::RatesStore::Memory
    def initialize(**)
      @currencies = Set.new
      super
    end

    def currencies
      @currencies.to_a
    end

    def add_rate(from, to, value)
      @currencies << from
      @currencies << to
      super
    end
  end
end
