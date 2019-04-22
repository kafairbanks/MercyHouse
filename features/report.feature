
  Feature: Generate room occupancy reports
    As an administrator
    I want to generate monthly room occupancy reports
    So that I can view room and visitor information over various time frames

    Background:
      Given I am logged in as an admin

    Scenario: See all relevant fields
      When I go to the new page for reports
      Then I should see all report fields

    Scenario:
      Given I am on the new page for reports
      When I fill out the report information
      And I press "Create Report"
      Then I should be on the download page for reports
