#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__)

require_relative "../framework"
require_relative "./helpers"

# ========================================================================

Testable.start_browser :firefox

on_visit(Home) do
  @active.login_form.click
  @active.username.set "admin"
  @active.password(id: 'password').set "admin"
  @active.login.click
  expect(@active.message.text).to eq('You are now logged in as admin.')
end

on(Navigation) do |page|
  page.page_list.click
  page.planets.click
  expect(page.planet_logo.exists?).to be true
end

on(Planet) do
  @active.weight.set 200
  @active.calculate.click
  expect(@active.mercury.value).to eq("75.6")
end

on(Navigation) do |page|
  page.page_list.click
  page.warp.wait_until(&:dom_updated?).click
  expect(page.warp_logo.exists?).to be true
end

on(WarpTravel) do
  @active.warp_factor.set 1
  @active.velocity.set 1
  @active.distance.set 4.3
  expect(@active.travel_time.text).to eq("4.3 years")
end

on(Navigation) do |page|
  page.page_list.click
  page.overlord.wait_until(&:dom_updated?).click
  expect(page.overlord_logo.exists?).to be true
end

on(Provision).countdown_value.set 5
on(Provision).provision_bomb.click

on(Bomb) do
  @active.trigger_code.set '1234'
  @active.bomb_state.click
  countdown_has_finished(@active)
  expect(@active.detonation.wait_until(&:dom_updated?)).to be_present
end

Testable.quit_browser
