

  Feature: Apply for a room
    As a patient
    I want to submit an application for a room
    So that I can be assigned a house by a church administrator

    Background:
      Given I am logged in as an admin

    Scenario: See application
      When I go to the new page for applications
      Then I should see all fields for the patient to fill out


    Scenario: Fill out first application
      Given I am on the new page for applications
      When I fill out application
      And press "Submit Application"
      Then I should be on the page for success