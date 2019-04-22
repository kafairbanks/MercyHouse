Feature: Red tag a patient

  As an administrator
  I want to mark the patient with a red tag in the database
  So that admins will be notified if a red-tagged patient re-applies.

  Background:
    Given I am logged in as an admin

  Scenario: See red tag box
    When I go to the edit page for applicants
    Then I should find "applicant_redFlag"

  Scenario: Check box
    Given I am on the edit page for applicants
    When I check "applicant_redFlag"
    And I press "Update"
    Then I should be on the show page for applicants
    And "redFlag" should be checked