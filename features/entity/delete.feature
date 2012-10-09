@http://www.pivotaltracker.com/story/show/22193899
Feature: admin can delete an entity
  In order to remove passwords
  as an admin
  I want to be able to delete entities

  Background:
    Given I am logged in as an admin
    And I have the following groups:
      | title   |
      | group 1 |
      | group 2 |
    And every group has 2 entities
    And I have the following entities:
      | group_title | entity_name        |
      | group 1     | ssh login for web1 |
    And I visit the entities page
    Then I should see a list of entities by group, with a title.

  Scenario: admin deletes an entity
    When I navigate to the "group 1" group page
    When I follow "ssh login for web1"
    And I press "Delete"
    Then I should see "Password was successfully deleted."
