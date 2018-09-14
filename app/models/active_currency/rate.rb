# frozen_string_literal: true

module ActiveCurrency
  class Rate < ApplicationRecord
    validates :from,
              :to,
              inclusion: { in: ->(_v) { Money.default_bank.store.currencies } },
              presence: true
    validates :value, numericality: { greater_than: 0 }

    scope :before, ->(date) { where(arel_table[:created_at].lt(date)) }

    def self.value_for(from, to, date = nil)
      scope = date ? before(date) : all

      scope
        .where(from: from, to: to)
        .order(:created_at)
        .last
        &.value
    end

    # DEPRECATED
    def self.current_value_for(from, to, date = nil)
      value_for(from, to, date)
    end
  end
end
