# Mercy House
Ruby on Rails development of Mercy House Reservation Service

Heroku Link: http://mercy-house.herokuapp.com

## Team Members
Product Owner: Katie Fairbanks

Scrum Master: Alex Davis

Brian McNaughton

Isaac Oviedo

Nick Nelson

Austin Miller

## Tool Versions
Ruby 2.4.5p335

Rails 5.2.2

Capybara 3.13.2

Cucumber 3.1.2

rspec-rails 3.7.2

Bundler 1.16.1

PostgreSQL: pg 1.1.4

## Current Available Pages
- Log In Page
- For Regular Users
     - New/See/Edit Applicant (Only their own)
     - New/See/Edit Application (Only their own)
     - Dashboard
- For Administrators
     - New/See/Edit/Delete Applicants
     - New/See/Edit/Delete Applications
     - New/See/Edit/Delete Bookings
     - New/See/Edit/Delete Houses
     - New/See/Edit/Delete Rooms
     - New/See/Edit/Delete Coordinators
     - Calendar
     - Generate Room Report
     - See/Edit User Roles

## How to Use the Application Right Now
You will start on the login page, where you can log in through Google or Facebook. 

By default, every user starts as a regular user (not an administrator), so after logging in, you will be redirected to a new applicant page, where you can input your personal information that will go along with your account. Then, you will be redirected to a new application page, where you can input your information specific to the current stay in a Mercy House that you are applying for. After both of these pages are finished, you will be redirected to a dashboard that shows the progress of your application. The first third of the status bar is application submission, the second third is background check completion, and the third third is the actual booking. Once an applicant is booked, their booking will appear below the status bar, so they can see which house they will be in.

As an administrator, you can many more privileges. First of all, you can see and edit the roles of any users that login to the website. If you would like to make someone an administrator, you can change their role. The administrator also has access to a calendar, which shows all of the bookings in an easy-to-read format, and the administrator can generate room reports by choosing a specific house and a time period to generate a .csv file that shows all of the bookings for that house for that time period.

Along with those functions, the administrators can directly interact with every facet of the database. This includes, applicants, applications, bookings, houses, rooms, and coordinators. Most of these pages show all of the items related to that subject with a search function at the top of the page.

You can see that on the See Applicants page, some applicants are highlighted in a light red. These applicants are "red-flagged", which means they will not be invited back to stay at a Mercy House. If they apply again, an administrator will recieve an email notifying that the red-flagged applicant applied again. 

Additionally, you can see that on the See Applications page, some applications are highlighted in a light red, or light green as well. Light red means that the booking is not completed, and the applicant's background check has not been cleared. White means that the booking is not completed, and the applicant's background check is completed. Finally, light green means that the booking is completed.
