Feature: Demo

  This feature file is solely for demonstration purposes, showing a series
  of acceptance tests across business functionality.

  Scenario: Weight on Planets
    Given an authenticated user on the planets page

    * a 200 pound person will weigh exactly 75.6 pounds on Mercury
    * a 200 pound person will weigh exactly 181.4 pounds on Venus

  Scenario: Travel Time to Stars
    Given an authenticated user on the warp travel page

    * a basic trip to "alpha centauri" takes 4.3 years
    * a basic trip to "epsilon eridani" takes 10.5 years

  Scenario: Bomb detonates after countdown
    Given an authenticated user on the overlord page
    And   an activated bomb with a countdown of "5" seconds

    When  the countdown finishes

    Then  the bomb will detonate
