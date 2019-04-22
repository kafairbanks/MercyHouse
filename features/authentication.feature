Feature: Authentication
  As a user
  I should not have access to admin features
  So that I cannot see or manipulate confidential information

  Scenario: Try to create a Booking
    When I go to the index page for applications
    Then I should be on the home page

  Scenario: Try to add a House Coordinator
    When I go to the new page for coordinators
    Then I should be on the home page

  Scenario: Try to see Applicants
    When I go to the index page for applicants
    Then I should be on the home page

  Scenario: Try to Add a New House
    When I go to the new page for mercyhomes
    Then I should be on the home page

  Scenario: Try to Generate a Room Report
    When I go to the new page for reports
    Then I should be on the home page

  Scenario: Try to See Bookings
    When I go to the index page for bookings
    Then I should be on the home page


  Scenario: Try to create a Booking as an applicant
    Given I am logged in as an applicant
    When I go to the index page for applications
    Then I should be on the dash

  Scenario: Try to add a House Coordinator as an applicant
    Given I am logged in as an applicant
    When I go to the new page for coordinators
    Then I should be on the dash

  Scenario: Try to see Applicants as an applicant
    Given I am logged in as an applicant
    When I go to the index page for applicants
    Then I should be on the dash

  Scenario: Try to Add a New House as an applicant
    Given I am logged in as an applicant
    When I go to the new page for mercyhomes
    Then I should be on the dash

  Scenario: Try to Generate a Room Report as an applicant
    Given I am logged in as an applicant
    When I go to the new page for reports
    Then I should be on the dash

  Scenario: Try to See Bookings as an applicant
    Given I am logged in as an applicant
    When I go to the index page for bookings
    Then I should be on the dash
