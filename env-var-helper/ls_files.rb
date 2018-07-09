require 'json'

env_file = "/files/#{ARGV[0]}"

if !File.exist?(env_file) || File.readlines(env_file).find {|line| line =~ /^ENV_VAR_HELPER=/ }.nil?
  raise "Env var file #{File.basename env_file} not found"
else # file exists, with ENV_VAR_HELPER present
  serialized_env_var_helper_data = File.readlines(env_file).find {|line| line =~ /^ENV_VAR_HELPER=/ }.sub('ENV_VAR_HELPER=','')
  env_var_helper_data = JSON.parse(serialized_env_var_helper_data)
  raise "Expected Array object" unless env_var_helper_data.is_a? Array

  puts
  puts "to view the complete contents of a file, run `docker run --rm -it -v $(pwd):/files dkcodeship/env-var-helper cat CONTAINER_DESTINATION_FILE ENV_FILE"
  puts
  puts "CONTAINER_DESTINATION - CONTENT_SUMMARY"
  puts "-----------------------------------"
  env_var_helper_data.each do |entry|
    entry_content = entry['content'].gsub("\n", ' ')
    entry_content = "#{entry_content[0...120]}..." if entry_content.length > 120
    puts "#{entry['container_destination']} - #{entry_content}"
  end
end
