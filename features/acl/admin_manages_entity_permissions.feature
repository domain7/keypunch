@http://www.pivotaltracker.com/story/show/30734179
Feature: Admin manages entity permissions
  In order to manage what users can access what entity
  As an admin
  I want to be able to permit ACL roles and users to access entities

  Background:
    Given I am logged in as an admin
    And I have the following users:
      | email           |
      | jon@example.com |
    And I have the following ACL roles:
      | role        |
      | development |
      | design      |
    And I have the following entities:
      | group_title | entity_name             |
      | group 1     | ssh login for web1      |
      | group 2     | password for go daddy   |
      | group 1     | login for webmin        |
      | group 2     | example people login     |
      | group 1     | login for clac go daddy |
    And I am on the entities page

  Scenario: admin grants ACL role access to entity
    When I go to the edit entity page for "password for go daddy"
    And I select "development" from "Roles"
    And I press "Save"
    Then I should see a successful entity update message
    And I should see all the ACL roles "password for go daddy" entity belongs to
    And I should see that this entity is now associated to the "development" ACL role

  Scenario: admin grants user access to entity
    When I go to the edit entity page for "password for go daddy"
    And I select "jon@example.com" from "Users"
    And I press "Save"
    Then I should see a successful entity update message
    And I should see all the users "password for go daddy" entity belongs to
    And I should see that this entity is now associated to the "jon@example.com" user
