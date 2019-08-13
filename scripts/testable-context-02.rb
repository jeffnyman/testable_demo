#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__)

require_relative "../framework"

# ========================================================================

Testable.start_browser :firefox

on_visit(Home).login_as_authenticated_user

on(Navigation).navigate.to_planet_page

on(Planet) do |action|
  action.convert(200)
  action.confirm_weight_on("Mercury").is(75.6)
end

on(Navigation).navigate.to_warp_travel_page

on(WarpTravel).confirm_basic_trip_for("alpha centauri").is(4.3)

on(Navigation).navigate.to_overlord_page

on(Provision).create_bomb(countdown: 5)

on(Bomb) do |action|
  action.enter_code('1234').then.activate_bomb
  action.check_that.countdown_has_finished
  action.confirm_detonation
end

Testable.quit_browser
