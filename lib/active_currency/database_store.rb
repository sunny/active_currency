# frozen_string_literal: true

module ActiveCurrency
  class DatabaseStore
    attr_reader :currencies

    def initialize(currencies)
      @currencies = currencies
    end

    def get_rate(from, to, date = nil)
      ActiveCurrency::Rate.current_value_for(from, to, date)
    end

    def add_rate(from, to, rate, date = nil)
      ActiveCurrency::Rate.create!(
        from: from,
        to: to,
        value: rate,
        created_at: date || Time.zone.now
      )
    end
  end
end
