require "data_accessible"

module Config
  module_function

  begin
    ConfigData = DataAccessible.sources do |source|
      source.data_load "config/config.yml"
    end

    Env = DataAccessible.sources do |source|
      source.data_load "config/environments.yml"
    end
  rescue Errno::ENOENT => error
    puts "ERROR IN CONFIG SETUP"
    puts "Unable to to find the file: #{error.message.split('/')[-1]}"
    puts "Path attempted: #{error.message.partition('- ').last}"
    exit
  end

  def config_set
    ConfigData.to_h
  end

  def env_set
    Env.to_h
  end

  def current
    ConfigData.config.current
  end

  def context(type = nil)
    type.tr!(' ', '_') unless type.nil?
    Env.groups.each do |env|
      next unless env.group == current.group
      env.servers.each do |env|
        next unless env.server == current.server
        return Hash[*env[current.user]].merge!("url" => env['url']) if type.nil?
        no_user_type_found(type) if Hash[*env[type]].empty?
        return Hash[*env[type]]
      end
    end
  end

  def no_user_type_found(type)
    raise NecessaryDataNotAvailableError, "The user '#{type}' was not found."
  end
end
