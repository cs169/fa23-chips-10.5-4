Feature: View State

  From the United States map 
  I want to see the state I click on
  
Scenario: Clicking on a state in the map
  Given I am on the national map
  When I click on the state with name "CA"



Scenario: Click on the Orange County
  Given I am on the state "CA" page
  When I click on the county with name "Orange" County and code "059" in state "CA"


Scenario: Click on the Fresno County
  Given I am on the state "CA" page
  When I click on the county with name "Fresno" County and code "019" in state "CA"

Scenario: Click on the Lyon County in Nevada
  Given I am on the state "NV" page
  When I click on the county with name "Lyon" County and code "019" in state "NV"
