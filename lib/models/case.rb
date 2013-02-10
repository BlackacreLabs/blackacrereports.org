class Case
  include Mongoid::Document

  field :style,   type: String
  field :decided, type: Date
  field :argued,  type: Date
  field :volume,  type: Integer
  field :page,	  type: Integer

  embeds_many :documents
end
