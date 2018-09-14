# frozen_string_literal: true

class CreateActiveCurrencyRates < ActiveRecord::Migration[5.0]
  def change
    create_table :active_currency_rates do |t|
      t.string :from
      t.string :to
      t.float :value
      t.datetime :created_at
    end

    add_index :active_currency_rates, %i[from to created_at]
  end
end
