$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'active_currency/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'active_currency'
  s.version = ActiveCurrency::VERSION
  s.authors = ['Sunny Ripert']
  s.email = ['sunny@sunfox.org']
  s.homepage = 'https://github.com/sunny/active_currency'
  s.summary = 'Rails plugin to store your currency regularly'
  s.description = 'Store your currency.'
  s.license = 'MIT'

  s.files =
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  # Rails plugin.
  s.add_dependency 'rails', '~> 5.0'

  # The Rails app needs to use money-rails as well.
  s.add_dependency 'money-rails'

  # API to get the currencies.
  s.add_dependency 'eu_central_bank'

  # DB for the dummy app.
  s.add_development_dependency 'sqlite3'

  # Unit testing.
  s.add_development_dependency 'rspec-rails'

  # Travel through time in specs.
  s.add_development_dependency 'timecop'

  # Useful for `binding.pry` in development.
  s.add_development_dependency 'pry'

  # Style guide.
  s.add_development_dependency 'rubocop'
end
