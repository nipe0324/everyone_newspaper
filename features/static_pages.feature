Feature:  View StaticPages (Home, About, Conatct)
  In order to know information cleary
  As a visiter
  I want to know what this site is on Homepage, what this site is in detail on Aboutpage and how to contact on Contactpage

  Scenario: View Home page
    Given I do not login
    When I go to the home page
    Then I should see "みんなの新聞"

  Scenario: View About page
    Given I am on the home page
    When I go to the about page
    Then I should see "このサイトについて"

  Scenario: View Conatct page
    Given I am on the home page
    When I go to the contact page
    Then I should see "お問い合わせ"