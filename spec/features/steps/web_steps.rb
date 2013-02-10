step 'I go to the homepage' do
  visit '/'
end

step 'I should see :text' do |text|
  page.should have_content(text)
end
