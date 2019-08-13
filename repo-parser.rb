#!/usr/bin/env ruby

require 'parser'
require 'parser/current'
require 'colorize'

def list_page_class(file)
  File.readlines(file).find_all{|line|
  line.start_with?("class")}.collect{|file|
  file.split("<")[0].gsub(/class/, "")}.map(&:strip)
end

def list_page_actions(file)
  File.readlines(file).find_all{|line|
  line.strip.start_with?("def")}.collect{|file|
  file.split("<")[0].gsub(/def/, "")}.map(&:strip)
end

page_definition = list_page_class(File.dirname(__FILE__) + "/models/planets/planet_weight.rb")
page_actions = list_page_actions(File.dirname(__FILE__) + "/models/planets/planet_weight.rb")

puts "\n\n"
puts "SHOW ME 'page actions for Planet'".green
puts "Page: #{page_definition.join().green}"
puts "Page Actions:"
page_actions.each do |action|
  puts "\t#{action}".yellow
end

page_definition = list_page_class(File.dirname(__FILE__) + "/models/stardates/stardate.rb")
page_actions = list_page_actions(File.dirname(__FILE__) + "/models/stardates/stardate.rb")

puts "\n\n"
puts "SHOW ME 'page actions for Stardate'".green
puts "Page: #{page_definition.join().green}"
puts "Page Actions:"
page_actions.each do |action|
  puts "\t#{action}".yellow
end
puts "\n\n"


class ActionViewer
  def initialize(filename)
    @ast = parse(filename)
  end

  def find(method_name)
    recursive_search_ast(@ast, method_name)
    return "\n  " + @method_source.yellow
  end

  private

  def parse(filename)
    Parser::CurrentRuby.parse(File.open(filename, "r").read)
  end

  def recursive_search_ast(ast, method_name)
    ast.children.each do |child|
      if child.class.to_s == "Parser::AST::Node"
        if (child.type.to_s == "def" or child.type.to_s == "defs") and (child.children[0].to_s == method_name or child.children[1].to_s == method_name)
          @method_source = child.loc.expression.source
        else
          recursive_search_ast(child, method_name)
        end
      end
    end
  end
end

puts "=================\n\n"

av = ActionViewer.new(File.dirname(__FILE__) + "/models/stardates/stardate.rb")
puts "SHOW ME 'calculate_tng_stardate from Stardate'".green
puts av.find("calculate_tng_stardate")
