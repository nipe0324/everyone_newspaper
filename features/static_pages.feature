Feature:  View StaticPages (Home, About, Conatct)
  In order to know information cleary
  As a visiter
  I want to know what this site is on Homepage, what this site is in detail on Aboutpage and how to contact on Contactpage

  Scenario: View Home page
    Given I do not login
    When I go to the home page
    Then I should see "みんなの新聞"

  Scenario: View Home page when already logined
    Given I already logined as "testuser@example.com", "foobar"
    When I go to the home page
    Then I should see "testuser@example.com"

  Scenario: View About page
    Given I am on "the home page"
    When I follow "このサイトについて"
    Then I should see "このサイトについて"

  Scenario: View Conatct page
    Given I am on "the home page"
    When I follow "お問い合わせ"
    Then I should see "お問い合わせ"