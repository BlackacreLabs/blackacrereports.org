Feature: Recent cases on the homepage

  Scenario: Case released today
    Given the following case:
      | style   | United States v. Doe |
      | number  | 13-001               |
      | decided | 2013-01-01           |
    When I go to the homepage
    Then I should see "United States v. Doe"
    And I should see "No. 13-001"
    And I should see "Jan. 1, 2013"
