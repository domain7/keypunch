Feature: Password Security
  In order to protect the sections of the site securely
  As a user
  I want to enforce secur passwords

  Scenario: user cannot reuse passwords
    Given I am logged in as an admin
    When I attempt to reuse a password
    Then I should see password has been used message

  Scenario: user cannot use an insecure password
    Given I am logged in as an admin
    When I attempt to use a weak password
    Then I should see password is too simple message
