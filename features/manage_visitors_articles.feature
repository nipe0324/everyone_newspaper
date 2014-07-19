Feature:  Manage Visitor's Articles
  In order to manage my articles I posted
  As a visitor
  I want to login, see the articles and create/edit/delete articles.

  # Login
  Scenario: Valid Sign In
    Given I have no account
    And I am on the signup page
    When I enter valid information ("testuser", "test@example.com", "foobarbar")
    Then I should see "testuser"
