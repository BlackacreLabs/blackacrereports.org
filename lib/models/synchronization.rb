require 'mongoid'

class Synchronization
  include Mongoid::Document

  field :time, type: Time

  field :commit_hash, type: String
  field :commit_time, type: Time
end
