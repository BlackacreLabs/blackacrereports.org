module HtmlSelectorsHelpers
  def selector_for(locator)
    case locator
    when "the page"
      "html > body"
    when /^"(.+)"$/
      $1
    else
      raise "Can't find mapping from \"#{locator}\" to a selector."
    end
  end
end
 
World(HtmlSelectorsHelpers)
