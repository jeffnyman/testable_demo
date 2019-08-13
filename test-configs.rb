#!/usr/bin/env ruby

# This file exists only to validate the data grabbing routines.
$: << './config'

require "config"

puts Config.config_set
puts "----------------"
puts Config.env_set
puts "----------------"

puts Config.current
puts "----------------"

puts Config.current.group
puts Config.current.server
puts Config.current.user
puts "----------------"

# Context of Config.current.user pulls from environments.yml:
# {"username"=>"admin", "password"=>"admin", "message"=>"You are now logged in as admin."}
puts Config.context(Config.current.user)
puts "----------------"

puts "----------------"
puts "(Context)"
puts "----------------"
puts Config.context
puts Config.context['url']
puts Config.context['username']
puts Config.context['password']
puts "----------------"
puts Config.context('admin')
puts Config.context('admin')['username']
puts Config.context('admin')['password']
puts "----------------"
puts Config.context('tester')
puts Config.context('tester')['username']
puts Config.context('tester')['password']

puts "----------------"

TestData = DataAccessible.sources do |source|
  source.data_load "data/stardates/stardate_conditions.yml"
end

puts TestData.to_h
puts TestData.stardate.invalid.conditions
