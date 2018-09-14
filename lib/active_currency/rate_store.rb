module ActiveCurrency
  # DatabaseStore with cache for calls without a date.
  class RateStore < DatabaseStore
    def get_rate(from, to, date = nil)
      return super if date

      Rails.cache.fetch(cache_key(from, to)) do
        super
      end
    end

    def add_rate(from, to, rate, date = nil)
      super

      Rails.cache.delete(cache_key(from, to))
    end

    private

    def cache_key(from, to)
      ['active_currency_rate', from, to]
    end
  end
end
