#!/bin/bash

# Varriables
wordlist_size=$1
wordlist_name=$2
password_length=$3
is_set=true
x=1

# Check for the help command
if [[ $1 == "-h" || $1 == "--help" ]]; then
  echo "Usage: $0 <wordlist_size> <wordlist_name> [password_length]"
  echo "       leave [password_length] empty for random password length"
  echo "Options: -h, --help Show this help message."
  echo "Example: $0 10 passwords.txt 12  # 10 passwords, each 12 chars."
  exit
fi

# Check if password length was set
if [[ -z $password_length ]]; then
  is_set=false
fi

# Clear wordlist
> $wordlist_name

# Main loop/
while [ $x -le $wordlist_size ]
do
  # Generate random password length if it wasn't set
  if [[ $is_set == false ]]; then
    password_length=$((($RANDOM % 12) + 3))
  fi

  # Generate password
  password=$(< /dev/urandom tr -dc 'A-Za-z0-9' | head "-c$password_length")
  wait
  echo $password >> $wordlist_name
  ((x++))
done

echo "Finished"
