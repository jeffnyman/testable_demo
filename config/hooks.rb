AfterConfiguration do |config|
  puts("Feature specs executed from: #{config.feature_dirs}")
end

Before('not @mock', 'not @manual') do
  browser_context_start
end

After('not @mock', 'not @manual') do
  browser_context_stop
end

After do |scenario|
  if ENV['QUICKFAIL']
    Cucumber.wants_to_quit = true if scenario.failed?
  end
end

AfterStep('@pause') do
  print "Press ENTER to execute the next step.\n"
  STDIN.getc
end

After do |scenario|
  Dir::mkdir('results') unless File.directory?('results')

  def screenshot_name(type, name)
    screenshot = "./results/#{type}_#{name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}.png"

    if Testable.browser
      encoded_img = Testable.browser.screenshot.base64
      Testable.browser.screenshot.save(screenshot)
      embed("data:image/png;base64,#{encoded_img}", "image/png")
    end
  end

  #if ENV['CAPTURE']
    if scenario.failed?
      screenshot = screenshot_name('FAILED', scenario.name)
    end
  #end

  if ENV['SCREENS']
    if scenario.passed?
      screenshot = screenshot_name('PASSED', scenario.name)
    end
  end
end
