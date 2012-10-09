@http://www.pivotaltracker.com/story/show/19621657
@pending
Feature: admin exports to keepass format
  In order to maintaint compatability with keep-ass
  As an Admin
  I wan to be able to export the current database in keep-ass format

  Scenario: admin exports keepass format
    Given I am logged in as an Admin
    When I follow “Export”
    Then I should see "Export format"
    When I press “Keepass”
    Then I should be on the download the file in keepass format
    And the downloaded keepass file should be identical to the imported file
