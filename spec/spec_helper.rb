require "pry"
require "timecop"

require File.expand_path("../../spec/dummy/config/environment.rb", __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../spec/dummy/db/migrate", __FILE__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../../db/migrate', __FILE__)

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end
