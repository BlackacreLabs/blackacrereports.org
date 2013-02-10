class Case
  include Mongoid::Document

  # Content
  field :style,   type: String
  field :decided, type: Date
  field :argued,  type: Date
  field :volume,  type: Integer
  field :page,	  type: Integer

  # Versioning
  field :commit_hash, type: String
  field :commit_time, type: Time
  field :data_path,   type: String

  embeds_many :documents
end
