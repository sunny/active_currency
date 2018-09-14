# frozen_string_literal: true

module ActiveCurrency
  class Rate < ApplicationRecord
    validates :from,
              :to,
              inclusion: { in: ->(_v) { Money.default_bank.store.currencies } },
              presence: true
    validates :value, numericality: { greater_than: 0 }

    def self.current_value_for(from, to, date = nil)
      scope = date ? where(arel_table[:created_at].lt(date)) : all

      scope
        .where(from: from, to: to)
        .order(:created_at)
        .last
        &.value
    end
  end
end
