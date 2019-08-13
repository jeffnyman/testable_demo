require "cucumber/rake/task"

desc "Run all feature specs"
task :features do
  Cucumber::Rake::Task.new(:features) do |t|
  end
end

desc "Send the canary into the mine"
task :canary do
  Cucumber::Rake::Task.new(:canary) do |t|
    t.cucumber_opts = '--tags @canary'
  end
end

desc "Run all feature specs with reporting"
task :report do
  Cucumber::Rake::Task.new(:report) do |t|
    t.cucumber_opts = '--profile report --tags ~@canary'
  end
end

desc "Run canary feature specs with dashboard"
task :dashboard do
  Cucumber::Rake::Task.new(:dashboard) do |t|
    t.cucumber_opts = '--profile dashboard --tags ~@canary'
  end
end

desc "Generate Execution Summary Report"
task :summary do
  system('rm results/execution-report.html')
  system('lucid_report -s results/ -o results/execution-report -t overview,features,scenarios,errors')
end

desc "Generate Repo Documentation"
task :docs do
  system('rm -rf doc')
  system("yardoc 'features/**/*.feature' 'lib/transforms/**/*.rb' 'steps/**/*.rb' 'models/**/*.rb'")
end
