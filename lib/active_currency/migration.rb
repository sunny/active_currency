# frozen_string_literal: true

module ActiveCurrency
  # Helps support previous version of Rails in migrations.
  if Rails.version > '5.0'
    class Migration < ActiveRecord::Migration[5.0]; end
  else
    class Migration < ActiveRecord::Migration; end
  end
end
