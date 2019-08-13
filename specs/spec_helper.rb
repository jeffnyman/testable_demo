require 'testable'
require 'data_builder'

include RSpec::Matchers

Dir["#{File.dirname(__FILE__)}/../config/config.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/../models/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  include Testable::Factory

  config.formatter = "documentation"
  config.color = true
  config.before(:example) { Testable.set_browser :chrome }
  config.after(:example)  { Testable.quit_browser }
end
