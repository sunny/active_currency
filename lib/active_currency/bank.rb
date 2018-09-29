# frozen_string_literal: true

module ActiveCurrency
  class Bank < Money::Bank::VariableExchange
    def initialize(rate_store = ActiveCurrency::RateStore.new)
      super(rate_store)
    end
  end
end
