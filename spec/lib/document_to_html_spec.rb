require_relative '../../lib/document_to_html'

require_relative '../../lib/models/case'
require_relative '../../lib/models/document'

require 'precedent'
require 'json'
require 'fabrication'

describe DocumentToHTML do
  it 'ignores comments' do
    hash = Precedent.load(
      <<-eos
This is a paragraph

% This is a comment
      eos
    )
    doc = Fabricate.build(:document, content: hash[:content])
    doc.html_rows.any? do |elem|
      elem.is_a?(Nokogiri::XML::Comment)
    end.should be_false
  end
end
