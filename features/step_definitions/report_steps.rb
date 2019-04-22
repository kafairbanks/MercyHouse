# Booking Step Definitions


# Scenario: See all relevant fields
Then (/^I should see all report fields$/) do
  expect(page).to have_field('report_mhomeid')
  expect(page).to have_field('StartDate')
  expect(page).to have_field('EndDate')
end

# Scenario: Room booking success
# Given (/^I am on the booking page$/) do
When (/^I fill out the report information$/) do
  xpath = "//*[@id='report_mhomeid']/option[2]"
  first_option = find(:xpath, xpath).text
  select(first_option, :from => 'report_mhomeid')
  fill_in('StartDate', :with => '2019-03-01')
  fill_in('EndDate', :with => '2019-05-01')
end
