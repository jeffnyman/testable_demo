Feature: Allow Custom Provisioning

  Background:
    Given an authenticated user on the overlord page

  Scenario: Bombs can be activated with custom activation codes
    Given a provisioned bomb with a custom activation code
    When  the bomb is activated with the custom activation code
    Then  the bomb will display as active
    And   the timer will start counting down

  Scenario: Bombs can be deactivated with custom deactivation codes
    Given a provisioned bomb with a custom deactivation code
    When  the bomb is deactivated with the custom deactivation code
    Then  the bomb will display as inactive
    And   the timer will stop counting down

  Scenario: Bombs can be activated with a custom countdown value
    Given a provisioned bomb with a custom countdown value
    Then  the countdown timer will be set to the custom countdown value
