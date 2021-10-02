#!/bin/bash
clear

echo "install development dependencies too? y/n"
read -r install

if [ "$install" == "y" ]; then
  bundle install
  read -p "Installation complete... Press enter to continue"
  clear
else
  bundle install--without development
  read -p "Installation complete... Press enter to continue"
  clear
fi