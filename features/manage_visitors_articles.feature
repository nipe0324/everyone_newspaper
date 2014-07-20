Feature:  Manage Visitor's Articles
  In order to manage my articles I posted
  As a visitor
  I want to login, see the list of my articles, create/edit/delete articles
    and of cource logout, signup, edit/delete my account.


  # Login
  # See the list of my articles
  Scenario: Valid login and see the list of my articles
    Given I have 1 article the title of which is "わたしが書いたアーティクル"
    And I am on "the login page"
    When I enter login information by "testuser@example.com" and "foobar"
    Then I should see "testuser"
    And I should see "わたしが書いたアーティクル"

  Scenario: Invalid login
    Given I have 1 account
    And I am on "the login page"
    When I enter login information by "invalid@example.com" and "invalid"
    Then I should see "ログイン"

  # Edit an article I posted
  # Delete an article I posted

  # Logout
  Scenario: Logout
    Given I already logined as "testuser@example.com" and "foobar"
    When I follow "ログアウト"
    Then I should see "みんなの新聞"

  # Sign Up
  Scenario: Valid sign up
    Given I have no account
    And I am on "the signup page"
    When I enter signup information by "testuser" and "testuser@example.com" and "foobar"
    Then I should see "testuser"

  Scenario: Invalid sign up
    Given I have no account
    And I am on "the signup page"
    When I enter signup information by "t" and "testuser@example.com" and "f"
    Then I should see "ユーザアカウント登録"
    And I should see "エラー"

  # Edit My Account
  Scenario: Edit success
    Given I already logined as "testuser@example.com" and "foobar"
    And Im on the update profile page of "testuser@example.com"
    When I update profile information by "changed" and "testuser@example.com" and "foobar"
    Then I should see "changed"

  Scenario: Edit failure
    Given I already logined as "testuser@example.com" and "foobar"
    And Im on the update profile page of "testuser@example.com"
    When I update profile information by "invalid" and "valid_name@example.com" and ""
    Then I should see "エラー"

  # Delete My Account
  Scenario: Delete success
    Given I already logined as "testuser@example.com" and "foobar"
    And Im on the update profile page of "testuser@example.com"
    When I follow "削除する"
    Then I should be on the home page
    And I should see "ご利用"
