# frozen_string_literal: true

module ActiveCurrency
  class Rate < ActiveRecord::Base
    validates :from,
              :to,
              presence: true
    validates :value, numericality: { greater_than: 0 }

    scope :before, ->(date) { where(arel_table[:created_at].lt(date)) }

    def self.value_for(from, to, date = nil)
      scope = date ? before(date) : all_scope

      scope
        .where(from: from, to: to)
        .order(:created_at)
        .last
        &.value
    end

    # Scope retrocompatibility for Rails 3.2.
    def self.all_scope
      respond_to?(:scoped) ? scoped : all
    end
  end
end
