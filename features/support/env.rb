# Code coverage
if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start 'rails'
  SimpleCov.coverage_dir 'coverage/cucumber'
end

require 'cucumber/rails'
require 'ruby-debug'
require Rails.root.join('spec', 'factories')
require Rails.root.join('features', 'support', 'paths')
require Rails.root.join('features', 'support', 'omniauth')
#require "#{Rails.root}/db/seeds.rb"
Capybara.default_selector = :css
ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end
