# frozen_string_literal: true

class AddRates < ActiveRecord::Migration[5.0]
  def up
    ActiveCurrency::AddRates.new.call
  end
end
