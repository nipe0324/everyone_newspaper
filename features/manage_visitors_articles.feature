Feature:  Manage Visitor's Articles
  In order to manage my articles I posted
  As a visitor
  I want to login, see the list of my articles, create/edit/delete articles
    and of cource logout, signup, edit/delete my account.


  # Login
  Scenario: Valid Login
    Given I have 1 account
    And I am on "the login page"
    When I enter login information by "testuser@example.com" and "foobar"
    Then I should see "testuser"

  Scenario: Invalid Login
    Given I have 1 account
    And I am on "the login page"
    When I enter login information by "invalid@example.com" and "invalid"
    Then I should see "ログイン"

  # See the list of my articles
  # Create an article
  # Edit an article I posted
  # Delete an article I posted

  # Logout
  Scenario: Logout
    Given I already logined as "testuser@example.com" and "foobar"
    When I follow "ログアウト"
    Then I should see "みんなの新聞"

  # Sign Up
  Scenario: Valid Sign Up
    Given I have no account
    And I am on "the signup page"
    When I enter signup information by "testuser" and "testuser@example.com" and "foobar"
    Then I should see "testuser"

  Scenario: Invalid Sign Up
    Given I have no account
    And I am on "the signup page"
    When I enter signup information by "t" and "testuser@example.com" and "f"
    Then I should see "ユーザアカウント登録"
    And I should see "エラー"

  # Edit My Account
  Scenario: Edit Success
    Given I already logined as "testuser@example.com" and "foobar"
    And Im on the update profile page of "testuser@example.com"
    When I update profile information by "changed" and "testuser@example.com" and "foobar"
    Then I should see "changed"

  Scenario: Edit Failure
    Given I already logined as "testuser@example.com" and "foobar"
    And Im on the update profile page of "testuser@example.com"
    When I update profile information by "invalid" and "valid_name@example.com" and ""
    Then I should see "エラー"

  # Delete My Account
  Scenario: Delete Success
    Given I already logined as "testuser@example.com" and "foobar"
    And Im on the profile page of "testuser@example.com"
    When I follow "削除する"
    Then I should be on the home page
    And I should see "ご利用ありがとうござました。"
