FROM ruby:3.4-slim

COPY cat_file.rb cp_file.rb env_var_helper.sh ls_files.rb rm_file.rb test ./
RUN chmod +x /env_var_helper.sh

ENTRYPOINT ["/env_var_helper.sh"]
