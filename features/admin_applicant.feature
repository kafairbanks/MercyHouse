Feature: Create a new applicant as an admin
  As an admin
  I want to create a new applicant
  So that they can create an application

  Background:
    Given I am logged in as an admin

  Scenario: See new applicant form
    When I go to the new page for applicants
    Then I should see all fields for a new applicant to fill out


  Scenario: Fill out applicant form
    Given I am on the new page for applicants
    When I fill out applicant form and press submit
    Then I should be on the index page for calendar