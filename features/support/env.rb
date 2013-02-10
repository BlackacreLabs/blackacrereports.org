require 'rspec/expectations'
require 'rack/test'
require 'capybara/cucumber'

require_relative '../../application'

BlackacreReports.environment = :test

class MyWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers

  Capybara.app = BlackacreReports
end

World { MyWorld.new }
