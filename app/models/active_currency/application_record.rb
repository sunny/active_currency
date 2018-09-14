# frozen_string_literal: true

module ActiveCurrency
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
