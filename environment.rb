ENV['RACK_ENV'] ||= 'development'

# Database
require 'mongoid'
require_relative 'lib/models'
Mongoid.load!('config/mongoid.yml')
