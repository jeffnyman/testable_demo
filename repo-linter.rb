#!/usr/bin/env ruby

require_relative './framework'

require 'cuke_sniffer'

cuke_sniffer = CukeSniffer::CLI.new(
  {
    :features_location => File.dirname(__FILE__) + '/features',
    :step_definitions_location => File.dirname(__FILE__) + '/steps',
    :hooks_location => File.dirname(__FILE__) + '/config'
  })
cuke_sniffer.output_html('./repo-health.html')
