@http://www.pivotaltracker.com/story/show/19490627
Feature: List the entities
  In order to list entities
  As a user
  I want to list some entities on the index page and provide ordering.

  Background:
    Given I have signed in
    And I have the following groups:
     | title   |
     | group 1 |
     | group 2 |
    And every group has 35 entities
    And I visit the entities page
    Then I should see a list of entities by group, with a title.

  Scenario: user views entities page
    When I order by "Name"
    Then I should see entities ordered by "Name"

  Scenario: user views all entities by group
    When I follow "group 1"
    Then I should see all the entities filtered by group "group 1"
