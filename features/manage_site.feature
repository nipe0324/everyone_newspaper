Feature:  Manage site
  In order to manage site (Everydays newspaper)
  As an administrator
  I want to login as admin and manage users and categories.

  # Login as admin
	Scenario: Login as admin
		Given I have an account as admin
		And I am on "the login page"
		When I enter login information as admin
		Then I should see the link of "ユーザ一覧"
		And I should see the link of "カテゴリ一覧"
		And I should see the link of "ログアウト"

  # Manage users
	Scenario: See user my page
    Given I have an account ( "ユーザ名", "testuser@example.com", "foobar" )
	  And I have an article ( "記事のタイトル", "初期のカテゴリ名", "初期の本文" ) of user ( "testuser@example.com" )
		And I already logined as admin
	  And I am on "the list of user page"
	  When I follow "ユーザ名"
	  Then I should see "ユーザ名"
	  And I should see "testuser@example.com"
	  And I should see "記事のタイトル"
	  And I should see "初期のカテゴリ名"
	  And I should see "初期の本文"
	  And I should not see "編集"
	  And I should not see "削除"

	Scenario: Delete user
    Given I have an account ( "ユーザ名", "testuser@example.com", "foobar" )
 		And I already logined as admin
	  And I am on "the list of user page"
	  When I follow "削除"
	  Then I should be on "the list of user page"
		And I should see "削除しました。"
	  
  # Manage categories
	Scenario: See the list of categories
		Given I have a category ("初期のカテゴリ名")
		And I already logined as admin
	  And I am on the mypage of admin
	  When I follow "カテゴリ一覧"
	  Then I should be on "the list of category page"
	  And I should see "初期のカテゴリ名"

	Scenario: Create a category
		Given I have no categories
		And I already logined as admin
	  And I am on "the list of category page"
	  When I fill in "カテゴリ名" with "追加したカテゴリ名"
	  And I press "カテゴリ名を追加"
	  Then I should be on "the list of category page"
	  And I should see "追加したカテゴリ名"

	Scenario: Update a category
		Given I have a category ("初期のカテゴリ名")
		And I already logined as admin
	  And I am on "the list of category page"
	  When I follow "編集"
	  And I fill in "カテゴリ名" with "編集したカテゴリ名"
	  And I press "カテゴリ名を更新"
	  Then I should be on "the list of category page"
	  And I should see "編集したカテゴリ名"

	Scenario: Delete a category
		Given I have a category ("初期のカテゴリ名")
		And I already logined as admin
	  And I am on "the list of category page"
	  When I follow "削除"
	  Then I should be on "the list of category page"
	  And I should not see "初期のカテゴリ名"


	Scenario: Fail to delete a category
    Given I have an account ( "ユーザ名", "testuser@example.com", "foobar" )
 		And I have an article ( "記事のタイトル", "初期のカテゴリ名", "初期の本文" ) of user ( "testuser@example.com" )
		And I already logined as admin
	  And I am on "the list of category page"
	  When I follow "削除"
	  Then I should be on "the list of category page"
	  And I should see "初期のカテゴリ名"
	  And I should see "削除できません"
