require 'testable'
include Testable::Context

require 'rspec'
include RSpec::Matchers

require 'awesome_print'
require 'data_builder'
require 'data_accessible'
require 'test_performance'

Dir[File.dirname(__FILE__) + '/config/config.rb'].each {|file| load file }
Dir[File.dirname(__FILE__) + '/common/core/*.rb'].each {|file| load file }
Dir[File.dirname(__FILE__) + '/models/**/*.rb'].each {|file| load file }

def analyze_from(results)
  ap results.marshal_dump
end
