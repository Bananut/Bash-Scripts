#!/bin/bash

version="1.0"

title=$(cat <<'EOF'
   ______      __           __      __
  / ____/___ _/ /______  __/ /___ _/ /_____  _____
 / /   / __ `/ / ___/ / / / / __ `/ __/ __ \/ ___/
/ /___/ /_/ / / /__/ /_/ / / /_/ / /_/ /_/ / /
\____/\__,_/_/\___/\__,_/_/\__,_/\__/\____/_/

EOF
)

pause_time=0.5

echo "$title"
echo "version $version, made by bananut"
sleep $pause_time
echo "Input first number"
read number_1
sleep $pause_time
echo "Input second number"
read number_2
sleep $pause_time
echo "Pick operation"
echo "Input 1 for +"
echo "Input 2 for -"
echo "Input 3 for *"
echo "Input 4 for /"
read operation
sleep $pause_time

case $operation in
  1)
    let result=$number_1+$number_2
    ;;
  2)
    let result=$number_1-$number_2
    ;;
  3)
    let result=$number_1*$number_2
    ;;
  4)
    let result=$number_1/$number_2
    ;;
  *)
    echo "Error, Invalid Operation"
    exit
    ;;
esac

echo "The result is:$result!"
