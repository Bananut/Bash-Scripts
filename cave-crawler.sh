#!/bin/bash

#Important varriabless
title=$(cat <<'EOF'
   ______                       ______                    __
  / ____/___ __   _____        / ____/________ __      __/ /__  _____
 / /   / __ `/ | / / _ \______/ /   / ___/ __ `/ | /| / / / _ \/ ___/
/ /___/ /_/ /| |/ /  __/_____/ /___/ /  / /_/ /| |/ |/ / /  __/ /
\____/\__,_/ |___/\___/      \____/_/   \__,_/ |__/|__/_/\___/_/

EOF
)

thanks_for_playing=$(cat <<'EOF'

┏┳┓┓     ┓    ┏        ┓    •    ╻
 ┃ ┣┓┏┓┏┓┃┏┏  ╋┏┓┏┓  ┏┓┃┏┓┓┏┓┏┓┏┓┃
 ┻ ┛┗┗┻┛┗┛┗┛  ┛┗┛┛   ┣┛┗┗┻┗┫┗┛┗┗┫•
                     ┛     ┛    ┛
EOF
)

in_cave=true
key=false
spider=null
weapon="fists"

#Introduction
echo "$title"
sleep 2
echo "You wake up in a cave, what do you do?"
sleep 1
echo "Write show to print the list of commands"

#This function manages the commands you can do when inside the cave
cave_function ()
{
        case $input in
                show)
                        echo -e "show\nlook_around\nsearch\nopen_door"
                        ;;
                look_around)
                        echo "You see a sturdy door and a rock in the corner"
                        ;;
                search)
                        echo "There are 2 places to search"
                        echo "Enter 0 to search behind the rock and 1 to search your pockets"
                        read input
                        case $input in
                                0)
                                        echo "You found a key and a sword"
                                        key=true
                                        ;;
                                1)
                                        echo "You didn't find anything :("
                                        ;;
                                esac
                        ;;
                open_door)
                        if [[ "$key" == true ]]; then
                                echo "You left the cave"
                                in_cave=false
                        else
                                echo "The door is locked!"
                        fi
                        ;;
                *)
                        echo "Enter show to show the list of commands"
                        ;;
        esac
}

#This function manages spiders attacks
spider_attack ()
{
        sleep 1
        attack=$(( $RANDOM % 3 ))
        case $attack in
                0)
                        echo "The spider fattaly bit you"
                        sleep 0.5
                        echo "You Died"
                        exit 1
                        ;;
                1)
                        echo "The spider missed"
                        ;;
                2)
                        echo "The spider rushed at you and accidently fell of a cliff!"
                        spider="dead"
                        ;;
        esac
}

#This function manages the commands when fighting the spider
spider_function ()
{
        case $input in
                show)
                        echo -e "show\nattack\ndraw_sword\ndeffend"
                        ;;
                attack)
                        if [[ "$weapon" == "fists" ]]; then
                                echo "You punched the spider, but fists don't do much"
                                spider_attack
                        else
                                echo "You slashed the spider in half"
                                spider="dead"
                        fi
                        ;;
                draw_sword)
                        echo "You drew your two handed claymore"
                        weapon="sword"
                        spider_attack
                        ;;
                deffend)
                        echo "You blocked spiders attacks"
                        ;;
                *)
                        echo "Enter show to list actions"
                        ;;
        esac
}

#While loop to get input more than 1 time
while [ "$in_cave" = true ]
        do
                read -p "Input command> " input
                cave_function
        done

#Introduction to the spider
sleep 1
spider=alive
echo "You escaped the cave, but behind the door is a massive spider"
echo "You have to fight!"

#While loop again
while [ "$spider" = "alive" ]
        do
                read -p "Input command> " input
                spider_function
        done

sleep 2
echo "You found an exit and escaped!"
sleep 2
echo "$thanks_for_playing"
echo "written by bananut, version 1.0"
