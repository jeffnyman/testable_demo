Feature: Provisioned Bombs Cannot Be Used Inappropriately

  Background:
    Given an authenticated user on the overlord page

  Scenario: Bombs cannot be activated with incorrect activation codes
    Given a provisioned bomb
    When  an incorrect activation code is entered
    Then  the bomb will display as inactive
    And   the bomb display indicates the activation code was incorrect

  Scenario: Bombs cannot be deactivated with incorrect deactivation codes
    Given an activated bomb
    When  an incorrect deactivation code is entered
    Then  the bomb will display as active
    And   the bomb display indicates the deactivation code was incorrect

  Scenario Outline: Bombs cannot be activated with invalid activation codes
    Given a provisioned bomb
    When  an invalid activation <code> is entered
    Then  the bomb will display as inactive
    And   the bomb display indicates the activation code was invalid

    Examples:
      | code   | comment                    |
      | ""     | no entry                   |
      | "12"   | too few numbers            |
      | "aaaa" | all letters                |
      | "1ab3" | some letters, some numbers |

  Scenario Outline: Bombs cannot be deactivated with invalid deactivation codes
    Given an activated bomb
    When  an invalid deactivation <code> is entered
    Then  the bomb will display as active
    And   the bomb display indicates the deactivation code was invalid

    Examples:
      | code   | comment                    |
      | ""     | no entry                   |
      | "12"   | too few numbers            |
      | "aaaa" | all letters                |
      | "1ab3" | some letters, some numbers |
