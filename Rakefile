unless ENV['RACK_ENV'] == 'production'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = './spec/**/*{_spec.rb,.feature}'
  end

  task :default => :spec

  namespace :db do
    desc "Delete all database records"
    task :clean do
      require_relative 'environment'
      require 'database_cleaner'
      DatabaseCleaner.orm = 'mongoid'
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
    end
  end
end

desc "Synchronize database with the data repository"
task :synchronize do
  ruby 'scripts/synchronize.rb'
end

