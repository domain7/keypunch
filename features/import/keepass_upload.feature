@http://www.pivotaltracker.com/story/show/19490705
@pending
Feature: admin uploads keepass database
  In order to migrate D7 away from keep-ass
  As an Admin
  I wan to be able to upload an export of the keepass database

  Scenario: admin imports keepass file
    Given I am logged in as an Admin
    And I am on the import keepass page
    When I upload a keepass file
    Then I should be on the entities page
    And I should see "1385 Entities imported, 169 Groups imported."
