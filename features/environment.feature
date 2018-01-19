Feature: Environment feature
  Test the possibility to add environment and interact with it

    Scenario: Create environment
      When I log in apimation.com as a regular user again
      Then I create a new environment with name: PREFRODews
      And I check if I added an environment with name: PREFROD
      Then I create an global variable called user with value babauskis2@gmail.com
      And I create an global variable called password with value parole123
      And I create an global variable called project_id with value project
      Then I create a collection with name: Loginews
      And I create a collection with name: Projectsews
      Then I create apimation.com request for login