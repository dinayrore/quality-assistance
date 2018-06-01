Feature: Doctors
  As a potential patient
  In order to determine the right health care professional for me
  I need to be able to search for doctors

  Scenario: Find a Doctor leads to Doctors Page
    Given I am on "www.healthcare-professional-website.com"
    When I follow "Find a Doctor"
    Then I should be on "/doctors"
    And I should see "Doctors"
    And I should see "Narrow Results"
    And I should see "Request an Appointment"

  Scenario: Find a Specialist leads to Doctors Page
    Given I am on "www.healthcare-professional-website.com"
    When I follow "Find a Specialist"
    Then I should be on "/doctors"
    And I should see "Doctors"
    And I should see "Narrow Results"
    And I should see "Request an Appointment"

  Scenario: Individual Doctor Page
    Given I am on "www.healthcare-professional-website.com"
    When I follow "Jane Smith, M.D."
    Then I should be on "/doctor/jane-smith-md"
    And I should see "Jane Smith, M.D."
    And I should see "About Dr. Smith"
    And I should see "Request an Appointment"
    And I should see "Locations"

  Scenario: Narrow Search
    Given I am on "www.healthcare-professional-website.com"
    When I follow "Narrow Results"
    And I select "Cardiology" from "Specialty"
    Then I should see "Jane Smith, M.D."
    And I should see "Request an Appointment"
