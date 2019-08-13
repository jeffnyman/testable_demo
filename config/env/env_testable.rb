require "testable"
World(Testable::Context)

require "data_builder"

def browser_context_start
  target = (ENV['BROWSER'] || 'chrome').to_sym
  if target == :headless
    Testable.start_browser :chrome, headless: true
  else
    # Testable.start_browser target
    Testable.start_browser :firefox
  end
end

def browser_context_stop
  Testable.quit_browser
end
