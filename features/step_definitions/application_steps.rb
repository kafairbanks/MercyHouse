# Application step definitions

# Scenario: See application
When (/^I go to the application page$/) do
  @applicant = Applicant.new(AName: 'John Doe', SPName: 'Jane Red')
  @applicant.save
  applicants_id = @applicant.id

  visit(new_application_path + '?applicants_id=' + applicants_id.to_s)
end

Then (/^I should see all fields for the patient to fill out$/) do
  expect(page).to have_field('ApplicationDate')
  expect(page).to have_field('HospitalName')
  expect(page).to have_field('DoctorName')
  expect(page).to have_field('TreatmentPlan')
  expect(page).to have_field('ArrivalDate')
  expect(page).to have_field('DepartureDate')
  expect(page).to have_unchecked_field('application_isFirstVisit')
  expect(page).to have_unchecked_field('application_appliedForLongTermHousing')
  # expect(page).to have_field('whereLongTermHousing')
  expect(page).to have_unchecked_field('application_insuranceCoversHousing')

  expect(page).to have_unchecked_field('application_wantsInfo')
  expect(page).to have_field('prayerRequests')
end


# Scenario: Fill out first application
When (/^I fill out application$/) do

  fill_in('applicants_id', :with => '1')
  fill_in('HospitalName', :with => 'Children\'s Hospital')
  fill_in('DoctorName', :with => 'Dr. Ramoray')
  fill_in('TreatmentPlan', :with => 'Chemo')
  fill_in('ArrivalDate', :with => '2019-04-20')
  fill_in('DepartureDate', :with => '2019-05-20')
  check('application_isFirstVisit')
  check('application_appliedForLongTermHousing')
  check('application_insuranceCoversHousing')
  check('application_wantsInfo')
  fill_in('prayerRequests', :with => 'For Whatanuggets (like McNuggets)')
end
