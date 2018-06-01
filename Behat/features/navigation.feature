Feature: Navigation
  As a potential patient
  In order to determine the right health care for me
  I need to be able to browse a hospital web site

  Background:
    Given I am on "www.healthcare-professional-website.com"

  Scenario: Home Page
    When I follow "Home"
    Then I should be on the homepage

  Scenario: Articles
    When I follow "Articles"
    Then I should be on "/articles"

  Scenario: Doctors
    When I follow "Doctors"
    Then I should be on "/doctors"

  Scenario: Locations
    When I follow "Locations"
    Then I should be on "/locations"

  Scenario: Footer Logo leads to Home page
    When I follow "Footer Logo"
    Then I should be on the homepage

  Scenario: Footer call number dials out
    When I follow "123.456.7890"
