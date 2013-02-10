ENV['RACK_ENV'] ||= 'development'
unless ENV['RACK_ENV'] == 'production'
  require 'dotenv'
  Dotenv.load
end

# Database
require 'mongoid'
require_relative 'lib/models'
Mongoid.load!('config/mongoid.yml')

# S3
require 'aws/s3'
AWS::S3::Base.establish_connection!(
  access_key_id: ENV['AMAZON_ACCESS_KEY_ID'],
  secret_access_key: ENV['AMAZON_SECRET_ACCESS_KEY']
)
include AWS
