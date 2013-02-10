require 'database_cleaner'
require 'database_cleaner/cucumber'

Before do
  DatabaseCleaner.start
end

After do |scenario|
  DatabaseCleaner.clean
end
