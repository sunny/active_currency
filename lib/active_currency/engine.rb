# frozen_string_literal: true

module ActiveCurrency
  class Engine < ::Rails::Engine
    isolate_namespace ActiveCurrency

    initializer :append_migrations do |app|
      next if app.root.to_s.match(root.to_s)

      paths = ActiveRecord::Tasks::DatabaseTasks.migrations_paths
      config.paths['db/migrate'].expanded.each do |path|
        paths << path
      end
      paths.uniq!
    end
  end
end
