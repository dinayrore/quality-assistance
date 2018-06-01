Feature: Articles
  As a potential patient
  In order to determine the right health care for me
  I need to be able to read organized health care articles

  Scenario: Article
    Given I am on "www.healthcare-professional-website.com"
    When I follow "Example Article"
    Then I should be on "/article/example-article"
    And I should see "Example Article"
    And I should see "Providers"
    And I should see "More Reading"
    And I should see "Request an Appointment"

  Scenario: SEO Article
    Given I am on "www.healthcare-professional-website.com"
    When I follow "Example Slideshow"
    Then I should be on "/article/example-slideshow"
    And I should see "Example Slideshow"
    And I should see "Providers"
    And I should see "More Reading"
    And I should see "Request an Appointment"

  Scenario: Slideshow
    Given I am on "www.healthcare-professional-website.com"
    Then I should see "Example SEO"
    And I should see "Providers"
    And I should see "More Reading"
    And I should see "Request an Appointment"
    And I should see "More About Example SEO"

  Scenario: Narrow Search
    Given I am on "www.healthcare-professional-website.com"
    When I follow "Narrow Results"
    And I select "Cardiology" from "Specialties"
    And I press "Apply"
    Then I should see "Example Article"
    And I should see "Example Slideshow"
