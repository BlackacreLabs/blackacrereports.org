ENV['RACK_ENV'] = 'test'
require_relative '../application'
require 'database_cleaner'
require 'turnip/capybara'
require 'capybara/rspec'

Capybara.app = BlackacreReports

RSpec.configure do |c|
  Dir.glob("spec/features/steps/**/*steps.rb") { |f| load f, true }

  c.before(:each) do
    DatabaseCleaner.start
  end

  c.after(:each) do
    DatabaseCleaner.clean
  end
end
