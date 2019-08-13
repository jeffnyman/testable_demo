Feature: Never Provision Invalid Bombs

  Background:
    Given an authenticated user on the overlord page

  Scenario Outline: Custom activation codes must be four numeric characters
    When  an invalid custom activation <code> is provided
    Then  the user is told the custom activation code is invalid

    Examples:
      | code    | comment                     |
      | "12345" | too many numbers            |
      | "12"    | too few numbers             |
      | "aaaa"  | all letters                 |
      | "1ab3"  | some letters, some numbers  |

  Scenario Outline: Custom deactivation codes must be four numeric characters
    When  an invalid custom deactivation <code> is provided
    Then  the user is told the custom deactivation code is invalid

    Examples:
      | code    | comment                     |
      | "12345" | too many numbers            |
      | "12"    | too few numbers             |
      | "aaaa"  | all letters                 |
      | "1ab3"  | some letters, some numbers  |

  Scenario Outline: Custom countdown values must be a whole number of seconds
    When  an invalid custom countdown <value> is provided
    Then  the user is told the custom countdown value is invalid

    Examples:
      | value | comment       |
      | "1.0" | decimal value |
      | ":30" | timer value   |
      | "abc" | letters       |
