#!/bin/bash

# display options to user
printf "what would you like to do?\n"
printf "  [1]Curriculum_spec test\n";
printf "  [2]Membership_spec \n";
printf "  [q]Quit \n";
read -r test

if [ "$test" == "q" ]; then
  exit 0
fi

cd ../spec/unit || exit

if [ "$test" == "1" ]; then
  rspec Curriculum_spec.rb
else
  rspec Membership_spec.rb
fi