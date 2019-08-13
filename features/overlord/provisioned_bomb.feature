Feature: Successful Bomb Provisioning

  Unless specified otherwise, a provisioned bomb will have the following:

    - Activation code:   1234
    - Deactivation code: 0000
    - Countdown value:   30

  Unless specified otherwise, an activated bomb will use the default
  provisioning.

  Background:
    Given an authenticated user on the overlord page

  Scenario: Bombs are not active by default
    Given a provisioned bomb
    Then  the bomb will display as inactive

  Scenario: Bombs have a default countdown
    Given a provisioned bomb
    Then  the countdown timer will be set to "30" seconds

  Scenario: Countdowns cannot be manipulated after provisioning
    Given a provisioned bomb
    Then  the countdown value cannot be changed

  Scenario: Bombs can be activated
    Given a provisioned bomb
    When  the bomb is activated
    Then  the bomb will display as active
    And   the timer will start counting down

  Scenario: Bombs can be deactivated
    Given an activated bomb
    When  the bomb is deactivated
    Then  the bomb will display as inactive
    And   the timer will stop counting down

  Scenario: Bomb detonates after countdown
    Given an activated bomb with a countdown of "5" seconds
    When  the countdown finishes
    Then  the bomb will detonate

  Scenario: Bomb detonates after three unsuccessful deactivation attempts
    Given an activated bomb
    When  an incorrect deactivation code is entered three times
    Then  the bomb will detonate

  Scenario: Keypad entry is allowed
    Given a provisioned bomb
    When  the bomb is activated by the keypad
    Then  the bomb will display as active

    When  a code is entered and deleted
    Then  the code is blank

    When  the bomb is deactivated by the keypad
    Then  the bomb will display as inactive
