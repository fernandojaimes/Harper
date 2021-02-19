#!/bin/bash

response=$1

DARK_GRAY='\033[1;30m'
NO_COLOR='\033[0m' 
GREEN='\033[0;32m'
RED='\033[0;31m'

BOLD_STYLE=$(tput bold)
NORMAL_STYLE=$(tput sgr0)

EXCLAMATION="${DARK_GRAY} ! ${NO_COLOR}"
QUESTION="${DARK_GRAY} ? ${NO_COLOR}"
MID_DOT="${DARK_GRAY} · ${NO_COLOR}"

prompt_exclamation () {
  printf "${BOLD_STYLE} ${EXCLAMATION} $1 ${NORMAL_STYLE}"
}

prompt_question () {
  printf "${BOLD_STYLE} ${QUESTION} $1 ${NORMAL_STYLE}"
  read -r response
}

start_container () {
  docker start harper-cli > /dev/null
  printf " ${EXCLAMATION} Harper is${GREEN} running.${NO_COLOR}\n"
}

stop_container () {
  docker stop harper-cli > /dev/null
  printf " ${EXCLAMATION} Harper${RED} stopped.${NO_COLOR}\n"
}

list_instances () {
  docker exec harper-cli bash -c "cd scripts; python3 get-instances.py"
}

container_status () {
  echo "running"
}


case $response in
  "start")
    start_container
    ;;
  "stop")
    stop_container
    ;;
  "ls")
    list_instances
    ;;
  *) echo "Invalid flag. Use 'harper help'";;
esac

