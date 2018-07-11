#!/bin/bash

set -e

ACTION=$1 && shift

case "${ACTION}" in
  cp)
    FILE_LOCATION=$1 && shift
    ENV_FILE=$1
    ruby /cp_file.rb $FILE_LOCATION $ENV_FILE
    ruby /ls_files.rb $ENV_FILE
    ;;
  rm)
    FILE_LOCATION=$1 && shift
    ENV_FILE=$1
    ruby /rm_file.rb $FILE_LOCATION $ENV_FILE
    ruby /ls_files.rb $ENV_FILE
    ;;
  ls)
    ENV_FILE=$1
    ruby /ls_files.rb $ENV_FILE
    ;;
  cat)
    FILE_LOCATION=$1 && shift
    ENV_FILE=$1
    ruby /cat_file.rb $FILE_LOCATION $ENV_FILE
    ;;
  *)
    echo "Usage: $0 {cp|rm|ls|cat}"
    exit 1
esac
