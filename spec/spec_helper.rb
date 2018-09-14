require 'pry'
require 'timecop'

# Load migrations
require File.expand_path('../spec/dummy/config/environment.rb', __dir__)
ActiveRecord::Migrator.migrations_paths =
  [File.expand_path('../spec/dummy/db/migrate', __dir__)]
ActiveRecord::Migrator.migrations_paths <<
  File.expand_path('../db/migrate', __dir__)
