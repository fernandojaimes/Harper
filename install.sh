#!/bin/bash

DARK_GRAY='\033[1;30m'
NO_COLOR='\033[0m' # No Color
GREEN='\033[0;32m'

BOLD_STYLE=$(tput bold)
NORMAL_STYLE=$(tput sgr0)

EXCLAMATION="${DARK_GRAY} ! ${NO_COLOR}" 
QUESTION="${DARK_GRAY} ? ${NO_COLOR}"
MID_DOT="${DARK_GRAY} · ${NO_COLOR}"

spinner() {
  local info="$1"
  local pid=$!
  local delay=0.001
  local spinstr='|/-\'
  while kill -0 $pid 2> /dev/null; do
    local temp=${spinstr#?}
    printf " [%c] $info" "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    local reset="\b\b\b\b\b\b"
      for ((i=1; i<=$(echo $info | wc -c); i++)); do
        reset+="\b"
      done
      printf $reset
  done
  # "Do you want start Harper now? [y/N]"
  # If Yes = docker run --name=harper
  # If No = To start Harper use "Harper start"
}

installation () {
  docker build -t harper . > /dev/null &
  spinner "Installing..."
  echo "alias harper='sh $DIRECTORY/scripts/menu.sh'" >> ~/.zshrc
  source ~/.zshrc > /dev/null
  printf " ${EXCLAMATION} Harper${GREEN} installed  ${NO_COLOR}\n"
  create_container 
  # printf "To start using Harper use command 'harper start'"
}

create_container () {
  docker run -it -d --name="harper-cli" harper > /dev/null & 
  spinner "Launching Haper..."
  printf " ${EXCLAMATION} Harper${GREEN} launched ${NO_COLOR}\n"
}

install_setup () {

  SHELL=$(echo $SHELL)
  DIRECTORY=$(echo $PWD)

  if [[ $SHELL == *"zsh"* ]]; then
    installation $1 
  elif [[ "$SHELL" == *"bash"* ]] || [[ "$SHELL" == *"sh"* ]]; then
    echo "alias harper='docker container ls'" >> ~/.zshrc
    source ~/.zshrc
  fi
  
  #  echo "$DIRECTORY/bin/menu.py"
  exit 0
  # echo "alias harper='docker container ls'" >> ~/.zshrc
}

show_info () {
  printf "${BOLD_STYLE} ${EXCLAMATION} Please, read the README before the installation. ${NORMAL_STYLE} \n" 
  printf " ${MID_DOT} You can read it using 'cat readme.md' in this directory.\n"
}

prompt_exclamation () {
  printf "${BOLD_STYLE} ${EXCLAMATION} $1 ${NORMAL_STYLE}"
}

prompt_question () {
  printf "${BOLD_STYLE} ${QUESTION} $1 ${NORMAL_STYLE}" 
  read -r response
}

func () {
  prompt_question "Are you read the README file? [y/N]" 

  if [[ $response =~ [yY] ]]; then
    install_setup 
  else
    show_info
    exit 0
  fi
}

func 

# echo "${BOLD_STYLE} ${EXCLAMATION}Are you read the README file? [y/N] ${NORMAL_STYLE}" 


