Feature: Admin Calendar
  As an administrator
  I want to see a calendar view of occupancy for each house
  So that I can view house guests and their information

  Background:
    Given I am logged in as an admin

  Scenario: See Calendar
    When I go to the index page for calendar
    Then I should see "Calendar"

  Scenario: Press today button
    Given I am on the index page for calendar
    When I press "Today"
    Then I should be on the index page for calendar

  Scenario: Select other options
    Given I am on the index page for calendar
    When I select "Mercy House 1" from "mhome"
    Then I should be on the index page for calendar

    Given I am on the index page for calendar
    When I select "January" from "_cal_month_2i"
    Then I should be on the index page for calendar
    And I should see "January"

    Given I am on the index page for calendar
    When I select "2016" from "_cal_year_1i"
    Then I should be on the index page for calendar
    And I should see "2016"



