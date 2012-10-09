@http://www.pivotaltracker.com/story/show/19490649
Feature: user views entity
  In order to view entities
  As a user
  I want to see the entity details

  Background:
    Given I have signed in
    And I have the following groups:
      | title   |
      | group 1 |
      | group 2 |
    And I am on the entities page

  Scenario: user views entity
    When I navigate to the "group 1" group page
    And I follow "New Password"
    And I fill in the following:
      | Name                  | New Key                     |
      | Username              | MYUSER                      |
      | Password              | SomePassword                |
      | Password confirmation | SomePassword                |
      | Protocol              | https                       |
      | URL                   | https://www.domainseven.com |
    And I press "Save"
    Then the new entity is created
