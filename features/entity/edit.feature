@http://www.pivotaltracker.com/story/show/19490671
Feature: user manages entity
  In order to view entities
  As a user
  I want to see the entity details

  Background:
    Given I have signed in
    And I have the following groups:
      | title   |
      | group 1 |
      | group 2 |
    And every group has 2 entities
    And I have the following entities:
      | group_title | entity_name        |
      | group 1     | ssh login for web1 |
    And I visit the entities page

  Scenario: user creates entity
    When I navigate to the "group 1" group page
    When I follow "New Password"
    And I fill in the entity fields
    And I press "Save"
    Then I should see "Password was successfully created."

  Scenario: user updates entity
    When I navigate to the "group 1" group page
    When I follow "ssh login for web1"
    And I follow "Edit"
    Then I should be on the edit entity page
    When I fill in the entity fields
    And I press "Save"
    Then I should see "Password was successfully updated."
