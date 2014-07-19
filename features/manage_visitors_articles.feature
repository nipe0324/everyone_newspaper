Feature:  Manage Visitor's Articles
  In order to manage my articles I posted
  As a visitor
  I want to login, see the articles and create/edit/delete articles.

  # Sign Up
  Scenario: Valid Sign Up
    Given I have no account
    And I am on the signup page
    When I enter signup information ("testuser", "testuser@example.com", "foobarbar")
    Then I should see "testuser"

  Scenario: Invalid Sign Up
    Given I have no account
    And I am on the signup page
    When I enter signup information ("t", "testuser@example.com", "f")
    Then I should see "ユーザアカウント登録"
    And I should see "エラー"

  # Login
  Scenario: Valid Login
    Given I have 1 account
    And I am on the login page
    When I enter login information ("testuser@example.com", "foobarbar")
    Then I should see "testuser"

  Scenario: Invalid Login
    Given I have 1 account
    And I am on the login page
    When I enter login information ("invalid@example.com", "invalid")
    Then I should see "ログイン"

  # Logout
  Scenario: Logout
    Given I just logined
    When I follow "ログアウト"
    Then I should see "みんなの新聞"
