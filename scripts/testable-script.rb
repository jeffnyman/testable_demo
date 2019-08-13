#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__)

require_relative "../framework"
require_relative "./helpers"

# ========================================================================

Testable.start_browser :firefox

page = Home.new
page.visit

page.login_form.click
page.username.set "admin"
page.password(id: 'password').set "admin"
page.login.click
expect(page.message.text).to eq('You are now logged in as admin.')

page = Navigation.new
page.page_list.click
page.planets.click
expect(page.planet_logo.exists?).to be true

page = Planet.new
page.weight.set 200
page.calculate.click
expect(page.mercury.value).to eq("75.6")

page = Navigation.new
page.page_list.click
page.warp.wait_until(&:dom_updated?).click     # - take out to show error
expect(page.warp_logo.exists?).to be true

page = WarpTravel.new
page.warp_factor.set 1
page.velocity.set 1
page.distance.set 4.3
expect(page.travel_time.text).to eq("4.3 years")

page = Navigation.new
page.page_list.click
page.overlord.wait_until(&:dom_updated?).click # - take out to show error
expect(page.overlord_logo.exists?).to be true

page = Provision.new
page.countdown_value.set 5
page.provision_bomb.click

page = Bomb.new
page.trigger_code.set '1234'
page.bomb_state.click
countdown_has_finished(page)   # - call to the helper
expect(page.detonation.wait_until(&:dom_updated?)).to be_present  # - take out to show error

Testable.quit_browser
