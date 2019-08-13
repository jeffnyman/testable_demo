system("rm -rf results") if File.exists?("results")
Dir.mkdir("results") unless File.exists?("results")
