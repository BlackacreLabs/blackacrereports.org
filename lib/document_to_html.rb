# encoding: UTF-8

require 'nokogiri'
require 'precedent'

class DocumentToHTML
  LEFT_COLUMN_WIDTH = 2
  MIDDLE_COLUMN_WIDTH = 7
  RIGHT_COLUMN_WIDTH = 12 - LEFT_COLUMN_WIDTH - MIDDLE_COLUMN_WIDTH

  def initialize(document)
    @document = document
    @short_name = document.short_name
  end

  def to_rows
    fragment = Nokogiri::XML::DocumentFragment.parse("")
    to_html.children.each { |node| add_rows(node, fragment) }
    fragment
  end

  def to_html
    Precedent.to_nokogiri(
      {
        :meta => {},
        :content => @document.content
      },
      @short_name + '-'
    )
  end

  private

  def add_rows(node, parent, quote=false)
    case node.name
    when 'p'
      row = Nokogiri::XML::Node.new('div', parent)
      row['class'] = 'row-fluid'
      parent.add_child(row)
      left = new_div("left span#{LEFT_COLUMN_WIDTH}", row)
      middle = new_div("span#{MIDDLE_COLUMN_WIDTH}", row)

      # Paragraph number
      number = Nokogiri::XML::Node.new('a', parent)
      number['class'] = 'number pull-right'
      number['id'] = "#{@short_name}-paragraph-#{node['data-number']}"
      number.inner_html = "¶#{node['data-number']}"
      left.add_child(number)

      # Content
      if quote
        quote = Nokogiri::XML::Node.new('blockquote', middle)
        quote.add_child(node.clone)
        middle.add_child(quote)
      else
        middle.add_child(node.clone)
      end
    when 'blockquote'
      node.children.each { |n| add_rows(n, parent, true) }
    when 'section'
      section = Nokogiri::XML::Node.new('section', parent)
      section['class'] = node['class']
      parent.add_child(section)
      node.children.each { |n| add_rows(n, section) }
    when 'aside'
      div = Nokogiri::XML::Node.new('div', parent)
      div['class'] = 'footnote'
      parent.add_child(div)
      node.children.each { |n| add_rows(n, div) }
    end
  end

  def new_div(classes, parent)
    ret = Nokogiri::XML::Node.new('div', parent)
    ret['class'] = classes
    parent.add_child(ret)
    ret
  end
end
