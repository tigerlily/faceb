Feature: Facebook session managment
  In order to use a Facebook session

  Scenario: Retrieve Facebook session
    Given I have facebook instance configured
    When I ask for the current Facebook session
    Then I should retrieve the current Facebook session
