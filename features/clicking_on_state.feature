Feature: View State

  From the United States map 
  I want to see the state I click on
  
Scenario: Clicking on a state in the map
  Given I am on the national map
  When I click on the state with name "CA"

Scenario: Click on the Orange County
  Given I am on the state "CA" page
  When I click on "Orange" County "059" in "CA"