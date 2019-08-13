Feature: Calculate Weight on Other Planets

  Implementation:

  Weights are calculated as the weight of a person multiplied by the
  surface gravity of the planet.

  Background:
    Given an authenticated user on the planets page

  Scenario: Weight on Mercury
    When the weight calculated is 200
    Then the weight on Mercury will be exactly 75.6
    And  the weight on Mercury will be roughly 75

  Scenario: Weight on Mercury (Condensed)
    * a 200 pound person will weigh exactly 75.6 pounds on Mercury
    * a 200 pound person will weigh approximately 75 pounds on Mercury

  Scenario: Weight on Mercury (Query)
    * a weight of 200 is what on Mercury?

  Scenario: Weight on Venus
    When the weight calculated is 200
    Then the weight on Venus will be exactly 181.4
    And  the weight on Venus will be roughly 180  
