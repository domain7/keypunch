@http://www.pivotaltracker.com/story/show/19490639
Feature: search entities
  In order to search entities
  As a user
  I want to search some entities on the index page

  Background:
    Given I have signed in
    And I have the following entities:
      | group_title | entity_name             |
      | group 1     | ssh login for web1      |
      | group 2     | password for go daddy   |
      | group 1     | login for webmin        |
      | group 2     | Domain people login     |
      | group 1     | login for clac go daddy |
    And I am on the entities page

  Scenario: user searches
    When I search for "group 1"
    Then I should see the following search results:
      | ssh login for web1      |
      | login for webmin        |
      | login for clac go daddy |
