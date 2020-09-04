# frozen_string_literal: true

module ActiveCurrency
  class Rate < ActiveRecord::Base
    validates :from, presence: true
    validates :to, presence: true
    validates :value, numericality: { greater_than: 0 }

    scope :before, ->(date) {
      where(arel_table[:created_at].lt(date))
    }

    def self.value_for(from, to, date = nil)
      from = Money::Currency.new(from)
      to = Money::Currency.new(to)
      return 1 if from == to

      scope = date ? before(date) : all
      scope
        .where(from: from.iso_code, to: to.iso_code)
        .order(:created_at)
        .last
        &.value
    end
  end
end
