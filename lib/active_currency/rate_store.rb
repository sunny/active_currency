# frozen_string_literal: true

module ActiveCurrency
  class RateStore < DatabaseStore
    include CacheableStore
  end
end
