@http://www.pivotaltracker.com/story/show/20738961
Feature: user administrates group
  In order to view, add and edit groups
  As a user
  I want to administrate groups

  Background:
    #Given I have signed in
    Given I am logged in as an admin
    And I have the following groups:
      | title   |
      | group 1 |
      | group 2 |
    And every group has 2 children
    And every group has 10 entities
    And I navigate to the "group 1" group page

  Scenario: user views group
    Then I should see the groups children
    And I should see the groups entities

  Scenario: user creates group
    When I follow "New Group"
    Then I should be on the new group page
    When I select "group 1" from "Parent"
    When I fill in "Title" with "New Group"
    And I press "Save"
    Then I should see "Group was successfully created."

  Scenario: user updates entity
    When I follow "Edit Group"
    Then I should be on the edit group page
    When I fill in "Title" with "New Group"
    And I select "group 2" from "Parent Group"
    And I press "Save"
    Then I should see "Group was successfully updated."
