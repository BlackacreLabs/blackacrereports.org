class Document
  include Mongoid::Document

  field :type,    type: String
  field :author,  type: String
  field :page,    type: Integer
  field :content, type: Array

  embedded_in :case
end
