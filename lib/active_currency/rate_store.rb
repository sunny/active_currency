module ActiveCurrency
  class RateStore
    attr_reader :currencies

    def initialize(currencies)
      @currencies = currencies
    end

    # Get rate from the cache or from the database.
    def get_rate(from, to, date = nil)
      return database_rate(from, to, date) if date

      Rails.cache.fetch(cache_key(from, to)) do
        database_rate(from, to)
      end
    end

    # Add rate to the database and clear the cache.
    def add_rate(from, to, rate, date = nil)
      ActiveCurrency::Rate.create!(
        from: from.to_s.upcase,
        to: to.to_s.upcase,
        value: rate,
        created_at: date || Time.zone.now,
      )

      Rails.cache.delete(cache_key(from, to))
    end

    private

    def cache_key(from, to)
      ["active_currency", "rate", from, to]
    end

    def database_rate(from, to, date = nil)
      ActiveCurrency::Rate.current_value_for(from.upcase, to.upcase, date)
    end
  end
end
