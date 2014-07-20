Feature:  Manage Visitor's Articles
  In order to manage my articles I posted
  As a visitor
  I want to login, see the list of my articles, create/update/delete articles
    and of cource logout, signup, edit/delete my account.


  # Login
  # See the list of my articles
  Scenario: Valid login and see the list of my articles
    Given I have an account as "testuser", "testuser@example.com", "foobar"
    And I have 1 article the title of which is "title" as "testuser@example.com"
    And I am on "the login page"
    When I enter login information as "testuser@example.com", "foobar"
    Then I should see "testuser"
    And I should see "title"

  Scenario: Invalid login
    Given I have an account as "testuser", "test@example.com", "foobar"
    And I am on "the login page"
    When I enter login information as "invalid@example.com", ""
    Then I should see "ログイン"

  # Create an article
  Scenario: Create valid articles
    Given I already logined as "testuser@example.com", "foobar"
    And Im on the new article page of "testuser@example.com"
    When I enter article information as "title", "content"
    Then I should see "title"
    And I should see "content"

  Scenario: Create invalid articles
    Given I already logined as "testuser@example.com", "foobar"
    And Im on the new article page of "testuser@example.com"
    When I enter article information as "", ""
    Then I should see "エラー"

  # Update an article I posted
  Scenario: Update valid articles
    Given I already logined as "testuser@example.com", "foobar"
    And I have 1 article the title of which is "title" as "testuser@example.com"
    And Im on the edit article page of which is "title" as "testuser@example.com"
    When I enter article information as "new_title", "new_content"
    Then I should see "new_title"
    And I should see "new_content"

  Scenario: Update invalid articles
    Given I already logined as "testuser@example.com", "foobar"
    And I have 1 article the title of which is "title" as "testuser@example.com"
    And Im on the edit article page of which is "title" as "testuser@example.com"
    When I enter article information as "", ""
    Then I should see "エラー"
    And I should not see "new_title"
    And I should not see "new_content"

  # Delete an article I posted
  Scenario: Update invalid articles
    Given I already logined as "testuser@example.com", "foobar"
    And I have 1 article the title of which is "title" as "testuser@example.com"
    And Im on the profile page of "testuser@example.com"
    When I follow "削除"
    Then I should not see "title"
    And I should see "testuser@example.com"

  # Logout
  Scenario: Logout
    Given I already logined as "testuser@example.com", "foobar"
    When I follow "ログアウト"
    Then I should see "みんなの新聞"

  # Sign Up
  Scenario: Valid sign up
    Given I have no account
    And I am on "the signup page"
    When I enter signup information as "testuser", "testuser@example.com", "foobar"
    Then I should see "testuser"

  Scenario: Invalid sign up
    Given I have no account
    And I am on "the signup page"
    When I enter signup information as "", "", ""
    Then I should see "ユーザアカウント登録"
    And I should see "エラー"

  # Edit My Account
  Scenario: Edit success
    Given I already logined as "testuser@example.com", "foobar"
    And Im on the update profile page of "testuser@example.com"
    When I update profile information as "changed", "testuser@example.com", "foobar"
    Then I should see "changed"

  Scenario: Edit failure
    Given I already logined as "testuser@example.com", "foobar"
    And Im on the update profile page of "testuser@example.com"
    When I update profile information as "", "", ""
    Then I should see "エラー"

  # Delete My Account
  Scenario: Delete success
    Given I already logined as "testuser@example.com", "foobar"
    And Im on the update profile page of "testuser@example.com"
    When I follow "削除する"
    Then I should be on the home page
    And I should see "ご利用"
