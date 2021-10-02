#!/bin/bash
clear

echo "install dependencies? (must be done at least once) y/n"
read -r install

if [ "$install" == "y" ]; then
  bash installation.sh
fi

echo "login now? y/n"
read -r login

if [ "$login" == "y" ]; then
  echo "Enter Username: "
  read -r username
  echo "$username"

  echo "Enter Password: "
  echo
    read -r -s password
fi

echo 'Run in developer mode?'
read -r devmode

echo "skip splash? y/n"
read -r skip

if [[ "$login" == "n" && "$devmode" == "y" ]]; then
  if [ "$skip" == "y" ]; then
    ruby ../app/index.rb -d -skip
  else
    ruby ../app/index.rb -d
  fi
else
  if [ "$skip" == "y" ]; then
      ruby ../app/index.rb -skip -login "$username" "$password"
    else
      ruby ../app/index.rb -login "$username" "$password"
    fi
fi



