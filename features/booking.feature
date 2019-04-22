
  Feature: Book a room
    As a church administrator
    I want to add a booked room to the database
    So that only one patient is assigned to a room at any date

    Background:
      Given I am logged in as an admin

    Scenario: See all relevant fields
      When I go to the new page for bookings
      Then I should see all booking fields

    Scenario: Room booking with no houses or rooms
      Given I am on the new page for bookings
      When I press "Submit Booking"
      Then I should be on the renew page for booking " "

    Scenario: Room booking success
      Given I am on the new page for bookings
      And I fill out booking form
      And press "Refresh to See Available Rooms"
      When I press "Submit Booking"
      Then I should be on the details page for booking

    Scenario: Room booking conflict
      Given I am on the new page for bookings
      When I fill out booking form
      And press "Submit Booking"
      When I go to the new page for bookings
      And I fill out booking form
      And press "Submit Booking"
      Then I should be on the renew page for booking "6"

    Scenario: Book room without background check
      Given I am on the new page for bookings
      When I fill out unchecked booking form
      And press "Submit Booking"
      Then I should be on the renew page for booking "2"
