# frozen_string_literal: true

class AddRates < ActiveRecord::Migration[5.1]
  def up
    ActiveCurrency::AddRates.new.call
  end
end
