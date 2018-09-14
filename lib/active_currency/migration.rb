# frozen_string_literal: true

module ActiveCurrency
  # Helps support previous version of Rails in migrations.
  if Rails.version > '4.1'
    class Migration < ActiveRecord::Migration[4.2]; end
  else
    class Migration < ActiveRecord::Migration; end
  end
end
