
Feature: Start a new applicant form
  As a new applicant
  I want to submit personal information to associate with my application
  So that I can fill out later applications more quickly

  Scenario: Login with facebook
    When I login as a new applicant
    Then I should be on the new page for applicants
    And I should see all fields for a new applicant to fill out

  Scenario: Fill out new applicant form
    Given I am logged in as a new applicant
    When I fill out applicant form and press submit
    Then I should be on the new page for applications

  Scenario: Login as returning user
    When I login as an applicant
    Then I should be on the dash