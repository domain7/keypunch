@http://www.pivotaltracker.com/story/show/19490601
Feature: User Login
  In order to get access to protected sections of the site
  As a user
  Should be able to login and sign out

  Scenario: user is not signed up
    Given I am not logged in
    When I go to the login page
    And I login as an invalid user
    Then I should see an invalid login message

  Scenario: user enters wrong password
    Given I am not logged in
    When I go to the login page
    And I attempt to login with an invalid password
    Then I should see an invalid login message

  Scenario: user signs in successfully with email
    Given I am not logged in
    When I go to the login page
    And I login as an authenticated user
    Then I should see a successful login message

  Scenario: user signs out
    Given I am logged in
    When I logout
    Then I should see a successful logout message
