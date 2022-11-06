# frozen_string_literal: true

module ActiveCurrency
  # Mixin to add caching capability to a rate store when getting the current
  # cache.
  module CacheableStore
    include AfterCommitEverywhere

    def get_rate(from, to, date = nil)
      return super if date

      Rails.cache.fetch(cache_key(from, to)) do
        super
      end
    end

    def add_rate(from, to, rate, date = nil)
      super

      after_commit do
        Rails.cache.delete(cache_key(from, to))
      end
    end

    private

    def cache_key(from, to)
      ['active_currency_rate', from, to]
    end
  end
end
