require 'json'

container_destination = ARGV[0]
env_file = "/files/#{ARGV[1]}"

if !File.exist?(env_file) || File.readlines(env_file).find {|line| line =~ /^ENV_VAR_HELPER=/ }.nil?
  raise "Env var file #{File.basename env_file} not found"
else # file exists, with ENV_VAR_HELPER present
  serialized_env_var_helper_data = File.readlines(env_file).find {|line| line =~ /^ENV_VAR_HELPER=/ }.sub('ENV_VAR_HELPER=','')
  env_var_helper_data = JSON.parse(serialized_env_var_helper_data)
  raise "Expected Array object" unless env_var_helper_data.is_a? Array

  entry = env_var_helper_data.find{|entry| entry['container_destination'] == container_destination}
  raise "No entry found for #{container_destination}, make sure you're providing an absolute path" if entry.nil?
  puts entry['content']
end
