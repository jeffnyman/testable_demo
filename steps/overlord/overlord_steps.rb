Given("a provisioned bomb") do
  on(Provision).create_bomb
end

Given(/^an activated bomb$/) do
  on(Provision).create_bomb
  on(Bomb).enter_code('1234').then.activate_bomb
end

Given("an activated bomb with a countdown of {string} seconds") do |seconds|
  on(Provision).create_bomb(countdown: seconds)
  on(Bomb).enter_code('1234').then.activate_bomb
end

Given(/^a provisioned bomb with a custom activation code$/) do
  on(Provision).create_bomb(activate: '9292')
end

Given(/^a provisioned bomb with a custom deactivation code$/) do
  on(Provision).create_bomb(deactivate: '1138')
end

Given(/^a provisioned bomb with a custom countdown value$/) do
  on(Provision).create_bomb(countdown: 15)
end

When("an incorrect activation code is entered") do
  on(Bomb).enter_code('9292').then.activate_bomb
end

When("an incorrect deactivation code is entered") do
  on(Bomb).enter_code('1138').then.deactivate_bomb
end

When("an invalid activation {string} is entered") do |code|
  on(Bomb).enter_code(code).then.activate_bomb
end

When("an invalid deactivation {string} is entered") do |code|
  on(Bomb).enter_code(code).then.deactivate_bomb
end

When("an invalid custom activation {string} is provided") do |code|
  on(Provision).create_bomb(activate: code)
end

When("an invalid custom deactivation {string} is provided") do |code|
  on(Provision).create_bomb(deactivate: code)
end

When("an invalid custom countdown {string} is provided") do |value|
  on(Provision).create_bomb(countdown: value)
end

When("the bomb is activated") do
  on(Bomb).enter_code('1234').then.activate_bomb
end

When(/^the bomb is deactivated$/) do
  on(Bomb).enter_code('0000').then.deactivate_bomb
end

When("the countdown finishes") do
  on(Bomb).check_that.countdown_has_finished
end

When("a code is entered and deleted") do
  on(Bomb).enter_code_in_keypad('7777').then.delete_code
end

When(/^the bomb is activated by the keypad$/) do
  on(Bomb).enter_code_in_keypad('1234').then.activate_bomb
end

When(/^the bomb is deactivated by the keypad$/) do
  on(Bomb).enter_code_in_keypad('0000').then.deactivate_bomb
end

When(/^an incorrect deactivation code is entered three times$/) do
  on(Bomb).enter_code('1139').then.deactivate_bomb
  on(Bomb).enter_code('1138').then.deactivate_bomb
  on(Bomb).enter_code('1137').then.deactivate_bomb
end

When(/^the bomb is activated with the custom activation code$/) do
  on(Bomb).enter_code('9292').then.activate_bomb
end

When(/^the bomb is deactivated with the custom deactivation code$/) do
  on(Bomb).enter_code('1138').then.deactivate_bomb
end

Then(/^the bomb will display as inactive$/) do
  verify on(Bomb).confirm_inactive_bomb_state
end

Then(/^the bomb will display as active$/) do
  verify on(Bomb).confirm_active_bomb_state
end

Then(/^the bomb display indicates the activation code was incorrect$/) do
  verify on(Bomb).confirm_incorrect_activation_message
end

Then(/^the bomb display indicates the deactivation code was incorrect$/) do
  verify on(Bomb).confirm_incorrect_deactivation_message
end

Then(/^the bomb display indicates the activation code was invalid$/) do
  verify on(Bomb).confirm_invalid_activation_message
end

Then(/^the bomb display indicates the deactivation code was invalid$/) do
  verify on(Bomb).confirm_invalid_deactivation_message
end

Then("the user is told the custom activation code is invalid") do
  verify on(Provision).confirm_invalid_activation_message
end

Then("the user is told the custom deactivation code is invalid") do
  verify on(Provision).confirm_invalid_deactivation_message
end

Then("the user is told the custom countdown value is invalid") do
  verify on(Provision).confirm_invalid_countdown_message
end

Then("the countdown timer will be set to {string} seconds") do |seconds|
  on(Bomb).countdown_value_is(seconds.to_i)
end

Then("the countdown value cannot be changed") do
  on(Bomb).confirm_countdown_cannot_be_changed
end

Then("the timer will start counting down") do
  on(Bomb).check_that.countdown_has_started
end

Then(/^the timer will stop counting down$/) do
  on(Bomb).check_that.countdown_has_stopped
end

Then("the bomb will detonate") do
  on(Bomb).confirm_detonation
end

Then(/^the code is blank$/) do
  on(Bomb).confirm_empty_code
end

Then(/^the countdown timer will be set to the custom countdown value$/) do
  on(Bomb).countdown_value_is(15)
end
