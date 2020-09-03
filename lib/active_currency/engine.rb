# frozen_string_literal: true

module ActiveCurrency
  class Engine < ::Rails::Engine
    isolate_namespace ActiveCurrency

    initializer :append_migrations do |app|
      app_context = app.root.to_s
      engine_context = root.to_s

      return if app_context.match engine_context

      migrations_path = ActiveRecord::Migrator.migrations_paths

      config.paths['db/migrate'].expanded.each do |expanded_path|
        migrations_path << expanded_path
      end

      migrations_path.uniq!
    end
  end
end
