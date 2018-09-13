$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_currency/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "active_currency"
  s.version = ActiveCurrency::VERSION
  s.authors = ["Sunny Ripert"]
  s.email = ["sunny@sunfox.org"]
  s.homepage = "https://github.com/sunny/active_currency"
  s.summary = "Rails plugin to store your currency regularly"
  s.description = "Store your currency."
  s.license = "MIT"

  s.files =
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"
  s.add_dependency "money-rails"
  s.add_dependency "eu_central_bank"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "timecop"

  # Useful for `binding.pry` in development.
  s.add_development_dependency "pry"
end
