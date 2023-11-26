Feature: View State

  From the United States map 
  I want to see the state I click on
  
Scenario: Clicking on a state in the map
  Given I am on the national map
  # your steps here
  When I click on the state with name "California"
  Then I should be on the state page for "California"


Scenario: Click on the County
  Given I am on the state CA page
  When I click on the county with FIPS code "045"
  Then I should be on the representatives page
