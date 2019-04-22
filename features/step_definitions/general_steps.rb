

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(URI.parse(path_to(page_name)).path)
end

Then /^(?:|I )should see a link to (.+)$/ do |page_name|
  expect(page).to have_link('', href: URI.parse(path_to(page_name)).path)
end

Then /^(?:|I )should find a (.+) with (.+)$/ do |type, field|
  expect(page).to have_css(type)
  within type do
    expect(page).to have_field(field)
  end
end

Then /^(?:|I )should find "(.+)"$/ do |field|
  expect(page).to have_field(field)
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  expect(page).to have_content(text)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )click "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end

Then /^"(.+)" should be checked$/ do |field|
  expect(page).to have_checked_field(field)
end