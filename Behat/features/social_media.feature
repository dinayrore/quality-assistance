Feature: Social Media Icons
  As a potential patient
  In order to determine a hospitals impact on my community
  I need to be able to browse a hospitals social media sites

  Background:
    Given I am on "www.healthcare-professional-website.com"

  Scenario: Twitter
    When I follow "Twitter"
    Then I should be on "Twitter"

  Scenario: Pinterest
    When I follow "Pinterest"
    Then I should be on "Pinterest"

  Scenario: Facebook
    When I follow "Facebook"
    Then I should be on "Facebook"

  Scenario: Google+
    When I follow "Google-plus"
    Then I should be on "Google+"
