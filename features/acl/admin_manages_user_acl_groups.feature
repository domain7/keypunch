@http://www.pivotaltracker.com/story/show/30734095
Feature: Admin manages acl user groups
  In order to Benefit
  As a Role/Stakeholder
  I want Feature/Behavior


In order to manage users and groups
As an admin
I want to be able to protect know what users are in what groups and manage those relationships

  Background:
    Given I am logged in as an admin
    And I have the following users:
      | email           |
      | jon@example.com |
    And I have the following ACL roles:
      | role        |
      | development |
      | design      |
    And I am on the users page

  Scenario: admin adds a user to a group
    When I go to the edit user page for "jon@example.com"
    And I select "development" from "Roles"
    And I press "Save"
    Then I should be on the user page for "jon@example.com"
    And I should see a successful user update message
    And I should see all the ACL roles "jon@example.com" belongs to
    And I should see that this user is now associated to the "development" ACL role

  Scenario: admin removes a user from a group
    When I go to the edit user page for "jon@example.com"
    And I unselect "development" from "Roles"
    And I press "Save"
    Then I should be on the user page for "jon@example.com"
    And I should see a successful user update message
    And I should see all the ACL roles "jon@example.com" belongs to
    And I should see that this user is not associated to the "development" ACL role
