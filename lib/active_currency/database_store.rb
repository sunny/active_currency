# frozen_string_literal: true

module ActiveCurrency
  # Currency Store that uses our ActiveRecord model to save and retrieve a
  # value.
  class DatabaseStore
    def get_rate(from, to, date = nil)
      ActiveCurrency::Rate.value_for(from, to, date&.to_datetime)
    end

    def add_rate(from, to, rate, date = nil)
      ActiveCurrency::Rate.create!(
        from: from,
        to: to,
        value: rate,
        created_at: date&.to_datetime || Time.zone.now
      )
    end
  end
end
