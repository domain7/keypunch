@http://www.pivotaltracker.com/story/show/30741821
Feature: users cannot access entities without proper permissions
  In order to secure entities
  As the system
  I want to make sure users can only access the entities they have been granted permission to

  Background:
    Given the following user ACL roles have been setup:
      | role        | email             |
      | admin       | admin@example.com |
      | design      | jon@example.com   |
      | development | sim@example.com   |
    And I have the following entities:
      | group_title | entity_name |
      | group 1     | test1       |
      | group 2     | test2       |
      | group 1     | test3       |
      | group 2     | test4       |
      | group 1     | test5       |
    And the following entities have the following permissions:
      | entity_name  | roles       | emails                           |
      | test1        | design      | jon@example.com,sim@example.com  |
      | test2        | development |                                  |
      | test3        |             |                                  |
      | test4        | Public      |                                  |

  Scenario: testing ACL 1
    Given I am logged in as user "jon@example.com"
    Then I should be able to access entity "test1"
    And I should not be able to access entity "test2"
    # test3 and test4 are identitcal by default every role must have at least 'Public' role
    And I should be able to access entity "test3"
    And I should be able to access entity "test4"

  Scenario: testing ACL 2
    Given I am logged in as user "sim@example.com"
    Then I should be able to access entity "test1"
    And I should be able to access entity "test2"
    And I should be able to access entity "test3"
    And I should be able to access entity "test4"

  Scenario: testing ACL 3 - admin
    Given I am logged in as an admin
    Then I should be able to access entity "test1"
    And I should be able to access entity "test2"
    And I should be able to access entity "test3"
    And I should be able to access entity "test4"
