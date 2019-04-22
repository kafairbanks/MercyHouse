# Finish new application as a new applicant

# Scenario: See new applicant form
# Scenario: add director to existing movie

Then (/^I should see all fields for a new applicant to fill out$/) do
  expect(page).to have_field('AName')
  expect(page).to have_field('AEmail')

  expect(page).to have_field('CGName')
  expect(page).to have_field('CGHomePhone')
  expect(page).to have_field('CGCellPhone')
  expect(page).to have_field('CGAddress')
  expect(page).to have_field('CGEmail')

  expect(page).to have_unchecked_field('applicant_AMinor')
  expect(page).to have_field('AAge')

  expect(page).to have_field('SPName')
  expect(page).to have_field('SPHomePhone')
  expect(page).to have_field('SPCellPhone')
  expect(page).to have_field('SPAddress')
  expect(page).to have_field('SPEmail')

  expect(page).to have_field('EC1Name')
  expect(page).to have_field('EC1HomePhone')
  expect(page).to have_field('EC1CellPhone')
  expect(page).to have_field('EC1Address')
  expect(page).to have_field('EC1Email')

  expect(page).to have_field('EC2Name')
  expect(page).to have_field('EC2HomePhone')
  expect(page).to have_field('EC2CellPhone')
  expect(page).to have_field('EC2Address')
  expect(page).to have_field('EC2Email')

  expect(page).to have_unchecked_field('applicant_allowsUseOfName')
end


When (/^I fill out applicant form and press submit$/) do
  fill_in('AName', :with => 'Alex Davis')
  fill_in('AEmail', :with => 'AllyDavie@hughesnet.com')

  fill_in('SPName', :with => 'Jeff Huang')
  fill_in('SPHomePhone', :with => '1234567890')
  fill_in('SPCellPhone', :with => '1991992876')
  fill_in('SPAddress', :with => '1787 HWY 169, Des Moines, IA 50273')
  fill_in('SPEmail', :with => 'jeff@gmail.com')

  fill_in('CGName', :with => 'Jeffery Dallas')
  fill_in('CGHomePhone', :with => '1231232345')
  fill_in('CGCellPhone', :with => '2343454567')
  fill_in('CGAddress', :with => '907 Cherry Drive')
  fill_in('CGEmail', :with => 'jeffery@hotmail.net')

  fill_in('EC1Name', :with => 'Jefferson Davis')
  fill_in('EC1HomePhone', :with => '1112223333')
  fill_in('EC1CellPhone', :with => '2223334444')
  fill_in('EC1Address', :with => '123 Sesame Street, Houston, TX 77788')
  fill_in('EC1Email', :with => 'jefferson@att.net')

  fill_in('EC2Name', :with => '')
  fill_in('EC2HomePhone', :with => '')
  fill_in('EC2CellPhone', :with => '')
  fill_in('EC2Address', :with => '')
  fill_in('EC2Email', :with => '')

  check('applicant_allowsUseOfName')
  click_button(value: "Submit Applicant") # class 'btn btn-primary'

end

Then (/^I should get a success message$/) do
  expect(page).to have_current_path(/#{Regexp.quote(new_application_path)}.*/)
end