#!/usr/bin/env ruby
require_relative './framework'

require 'cql'

cql_repo = CQL::Repository.new(File.dirname(__FILE__) + "/features")

puts "\n\n"

puts "Give me all features".green
puts "SELECT name, source_line FROM features".yellow

results = cql_repo.query do
  select name, source_line
  from features
end

puts results

puts "\n\n"

puts "Give me any features tagged with @canary".green
puts "SELECT name FROM features WITH tags '@canary'".yellow

results = cql_repo.query do
  select name
  from features
  with tags '@canary'
end

puts results
