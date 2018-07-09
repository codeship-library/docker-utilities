require 'json'

local_file_info, container_destination = ARGV[0].split(':')
local_filename = File.basename(local_file_info)
env_file = "/files/#{ARGV[1]}"
content = File.read("/files/#{local_filename}")
entry = { 'content': content, 'container_destination': container_destination }

if !File.exist?(env_file) || File.readlines(env_file).find {|line| line =~ /^ENV_VAR_HELPER=/ }.nil?
  File.open(env_file, 'a') {|f| f.puts "ENV_VAR_HELPER=#{[entry].to_json}" }
else # file exists, with ENV_VAR_HELPER present
  serialized_env_var_helper_data = File.readlines(env_file).find {|line| line =~ /^ENV_VAR_HELPER=/ }.sub('ENV_VAR_HELPER=','')
  env_var_helper_data = JSON.parse(serialized_env_var_helper_data)
  raise "Expected Array object" unless env_var_helper_data.is_a? Array

  if env_var_helper_data.find {|entry| entry['container_destination'] == container_destination}
    env_var_helper_data.map! {|entry| entry['content'] = content if entry['container_destination'] == container_destination; entry}
  else
    env_var_helper_data << entry
  end

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
