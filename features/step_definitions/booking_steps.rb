# Booking Step Definitions


# Scenario: See all relevant fields
Then (/^I should see all booking fields$/) do
  expect(page).to have_field('applicants_id')
  expect(page).to have_field('application_id')
  expect(page).to have_field('mercyrooms_id')
  expect(page).to have_field('StartDate')
  expect(page).to have_field('EndDate')
end

# Scenario: Room booking success
# Given (/^I am on the booking page$/) do
When (/^I fill out unchecked booking form$/) do
  fill_in('applicants_id', :with => '2')
  fill_in('application_id', :with => '2')
  fill_in('mercyrooms_id', :with => '1')
  fill_in('StartDate', :with => '2019-09-01')
  fill_in('EndDate', :with => '2019-09-21')
end


# Scenario: Room booking success
# Given (/^I am on the booking page$/) do
When (/^I fill out booking form$/) do
  fill_in('applicants_id', :with => '5')
  fill_in('application_id', :with => '6')
  fill_in('mercyrooms_id', :with => '1')
  fill_in('StartDate', :with => '2019-09-01')
  fill_in('EndDate', :with => '2019-09-21')
end
