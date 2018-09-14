# frozen_string_literal: true

# Helps support previous version of Rails in migrations.
module ActiveCurrency
  if Rails.version > '4.1'
    Migration < ActiveRecord::Migration[4.2]
  else
    Migration < ActiveRecord::Migration
  end
end
