source :rubygems

ruby '1.9.3'

# Web
gem 'sinatra'
gem 'sinatra-partial'
gem 'thin'

# Misc
gem 'rake'
gem 'haml'

# Databae
gem 'mongoid', '~>3.0'
gem 'bson_ext'

# Homegrown
gem 'bluebook', :git => 'git://github.com/BlackacreLabs/bluebook.git'
gem 'precedent', :git => 'git://github.com/BlackacreLabs/precedent.git'

group :development do
  gem 'foreman'

  gem 'guard-bundler'
  gem 'guard-coffeescript'
  gem 'guard-rack'
  gem 'guard-rspec'
  gem 'guard-sass'

  gem 'rb-fchange', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', '0.8.8', :require => false
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'faker'
  gem 'rspec'
  gem 'turnip'
end
