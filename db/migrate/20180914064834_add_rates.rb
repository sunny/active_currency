# frozen_string_literal: true

class AddRates < ActiveCurrency::Migration
  def up
    ActiveCurrency::AddRates.new.call
  end
end
