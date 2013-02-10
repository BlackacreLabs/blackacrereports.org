require_relative '../document_to_html'

require 'mongoid'

class Document
  include Mongoid::Document

  field :type,    type: String
  field :author,  type: String
  field :page,    type: Integer
  field :content, type: Array

  embedded_in :case

  def short_name
    if type == 'Syllabus'
      'Syllabus'
    else
      author
    end
  end

  def type_icon
    if /court/i =~ type
      'icon-home'
    elsif /concurring/i.match(type) && !/dissenting/.match(type)
      'icon-thumbs-up'
    elsif /dissenting/i.match(type) && !/concurring/.match(type)
      'icon-thumbs-down'
    elsif /syllabus/i.match(type)
      'icon-list-alt'
    else
      'icon-user'
    end
  end

  def parenthetical
    if type == 'Court'
      nil
    else
      "#{author}, #{type.downcase}"
    end
  end

  def long_name
    if type == 'Syllabus'
      'Syllabus'
    else
      author + ', ' + type.downcase
    end
  end

  def html_rows
    DocumentToHTML.new(self).to_rows
  end
end
