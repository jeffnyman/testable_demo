#!/usr/bin/env ruby

require_relative './framework'

Testable.set_browser :chrome

on_view(Home).login_as_authenticated_user

on(Navigation).navigate_to("planet weight calculator")

on(Planet).convert('200')
on(Planet).confirm_weight_on('Mercury').is(75.6)

analyze_from(Testable.browser.performance)

Testable.quit_browser
