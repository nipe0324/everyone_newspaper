Feature:  Manage Visitor's Articles
  In order to manage my articles I posted
  As a visitor
  I want to login, see the list of my articles, manage articles
    and of cource logout, signup, edit/delete my account.

  # Login
  # See the list of my articles
  Scenario: Valid login and see the list of my articles
    Given I have an account ( "初期ユーザ名", "testuser@example.com", "foobar" )
    And I have an article ( "init_title", "init_cate", "init_content" ) of user ( "testuser@example.com" )
    And I am on "the login page"
    When I enter login information as "testuser@example.com", "foobar"
    Then I should see "初期ユーザ名"
    And I should see "title"

  Scenario: Invalid login
    Given I have an account ( "初期ユーザ名", "testuser@example.com", "foobar" )
    And I am on "the login page"
    When I enter login information as "", ""
    Then I should see "ログイン"
    And I should see "誤り"

  # Create an article
  Scenario: Create valid articles
    Given I have a category ("init_cate")
    And I already logined as "testuser@example.com", "foobar"
    And Im on the new article page of "testuser@example.com"

    When I fill in "タイトル" with "new_title"
    And I select "init_cate" from "カテゴリ"
    And I fill in "本文" with "new_content"
    And I press "記事を投稿する"

    Then I should see "new_title"
    And I should see "new_content"
    And I should see "init_cate"

  Scenario: Create invalid articles
    Given I have a category ("init_cate")
    And I already logined as "testuser@example.com", "foobar"
    And Im on the new article page of "testuser@example.com"

    When I fill in "タイトル" with ""
    And I fill in "本文" with ""
    And I press "記事を投稿する"

    Then I should see "エラー"

  # Update an article I posted
  Scenario: Update valid articles
    Given I have an account ( "初期ユーザ", "testuser@example.com", "foobar" )
    And I have an article ( "init_title", "init_cate", "init_content" ) of user ( "testuser@example.com" )
    And I have a category ("up_cate")
    And I already logined as "testuser@example.com", "foobar"
    And Im on the edit article page ( "init_title" ) of "testuser@example.com"

    When I enter update article information as "update_title", "up_cate", "update_content"

    Then I should see "update_title"
    And I should see "update_content"
    And I should see "up_cate"

  Scenario: Update invalid articles
    Given I already logined as "testuser@example.com", "foobar"
    And I have an article ( "init_title", "init_cate", "init_content" ) of user ( "testuser@example.com" )
    And Im on the edit article page ( "init_title" ) of "testuser@example.com"
    When I enter update article information as "", "", ""    
    Then I should see "エラー"

  # Delete an article I posted
  Scenario: Update invalid articles
    And I already logined as "testuser@example.com", "foobar"
    Given I have an article ( "init_title", "init_cate", "init_content" ) of user ( "testuser@example.com" )
    And Im on the profile page of "testuser@example.com"
    When I follow "削除"
    Then I should not see "init_title"
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
