Feature: Appointments
  As a potential patient
  In order to see a health care professional
  I need to be able to request an appointment

  Scenario: Request an Appointment CTA
    Given I am on "www.healthcare-professional-website.com"
    When I follow "Request an Appointment"
    Then I should be on "/form/request-appointment"
    And I should see "Request an Appointment"
    And I should see "fill out the form below."

  Scenario: Request an Appointment Form
    Given I am on ""
    When I fill in "first-name" with "First Name"
    And I fill in "last-name" with "Last Name"
    And I fill in "email" with "testmail@email.com"
    And I fill in "phone" with "1234567890"
    And I press "Request an Appointment"
    Then I should be on "/thank-you-appointment-request"
