Feature: Login Page
  As an administrator
  I want to have a home page
  So that I can easily access the admin features

  Background:
    Given I am logged in as an admin

  Scenario: See several links
    When I go to the login page
    Then I should see a link to the index page for applicants
    And I should see a link to the index page for bookings
    And I should see a link to the new page for mercyhomes
    And I should see a link to the index page for applications
    And I should see a link to the new page for reports

    Scenario: Click Create a Booking
      Given I am on the login page
      When I click "Create a Booking"
      Then I should be on the index page for applications

    Scenario: Click See Applicants
      Given I am on the login page
      When I click "Applicants"
      Then I should be on the index page for applicants

    Scenario: Click Add a House Coordinator
      Given I am on the login page
      When I click "Create a Housing Coordinator"
      Then I should be on the new page for coordinators

    Scenario: Click Add a New House
      Given I am on the login page
      When I click "Create a House"
      Then I should be on the new page for mercyhomes

    Scenario: Click Generate a Room Report
      Given I am on the login page
      When I click "Generate Room Report"
      Then I should be on the new page for reports

    Scenario: Click See Bookings
      Given I am on the login page
      When I click "See Bookings"
      Then I should be on the index page for bookings
