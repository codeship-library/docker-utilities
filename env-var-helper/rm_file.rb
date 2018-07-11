require 'json'

container_destination = ARGV[0]
env_file = "/files/#{ARGV[1]}"

if !File.exist?(env_file) || File.readlines(env_file).find {|line| line =~ /^ENV_VAR_HELPER=/ }.nil?
  raise "Env var file #{File.basename env_file} not found"
else # file exists, with ENV_VAR_HELPER present
  serialized_env_var_helper_data = File.readlines(env_file).find {|line| line =~ /^ENV_VAR_HELPER=/ }.sub('ENV_VAR_HELPER=','')
  env_var_helper_data = JSON.parse(serialized_env_var_helper_data)
  raise "Expected Array object" unless env_var_helper_data.is_a? Array

  env_var_helper_data.delete_if {|entry| entry['container_destination'] == container_destination}

  File.open("#{env_file}.new", 'w') do |file|
    File.readlines(env_file).each do |env_line|
      if env_line =~ /^ENV_VAR_HELPER=/
        file.puts "ENV_VAR_HELPER=#{env_var_helper_data.to_json}"
      else
        file.puts env_line
      end
    end
  end

  File.delete(env_file)
  File.rename("#{env_file}.new", env_file)
end
