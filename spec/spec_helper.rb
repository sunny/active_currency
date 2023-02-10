# frozen_string_literal: true

require "pry"
require "timecop"

# Load migrations
require File.expand_path("../spec/dummy/config/environment.rb", __dir__)
ActiveRecord::Migrator.migrations_paths =
  [File.expand_path("../spec/dummy/db/migrate", __dir__)]
ActiveRecord::Migrator.migrations_paths <<
  File.expand_path("../db/migrate", __dir__)

RSpec.configure do |config|
  config.example_status_persistence_file_path = "tmp/rspec_examples.txt"
end
