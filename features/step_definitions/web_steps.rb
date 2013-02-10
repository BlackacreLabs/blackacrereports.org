When /^I go to the homepage$/ do
    visit '/'
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end
