# frozen_string_literal: true

module ActiveCurrency
  class Configuration
    def initialize
      @remote_bank = :eu_central_bank
      @open_exchange_rates_app_id = nil
      @multiplier = {}
    end

    attr_accessor :remote_bank,
                  :open_exchange_rates_app_id,
                  :multiplier
  end
end
