@http://www.pivotaltracker.com/story/show/20738949
Feature: Google Auth
  In order to get access to protected sections of the site
  As a user
  Should be able to use my google account to log in

@omniauth_test
  Scenario: User signs in with Google
    Given I am not logged in
    When I go to the home page
    And I follow "Sign in with your Google account."
    Then I should see a successful google auth message
