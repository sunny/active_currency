# frozen_string_literal: true

module ActiveCurrency
  class RateStore < DatabaseStore
    include CacheableStore

    attr_reader :currencies

    def initialize(currencies)
      @currencies = currencies
    end
  end
end
