# Bash SSH Brute-Force Login Script
```
  _________ _________ ___ ___          __________                __          
 /   _____//   _____//   |   \         \______   \_______ __ ___/  |_  ____  
 \_____  \ \_____  \/    ~    \  ______ |    |  _/\_  __ \  |  \   __\/ __ \ 
 /        \/        \    Y    / /_____/ |    |   \ |  | \/  |  /|  | \  ___/ 
/_______  /_______  /\___|_  /          |______  / |__|  |____/ |__|  \___  >
       \/        \/       \/                  \/                         \/
version 1.1, made by bananut
```

## Overview
A script for brute-forcing ssh passwords

## How do I use this?
First you need to install sshpass
```bash
sudo apt install sshpass
```
Then use this command to execute
```bash
./ssh-brute.sh <user> </path/to/wordlist.txt> <target_adress> <speed>
```
Help Command:
```
Info: an ssh brute-forcing tool for cracking a users password
Usage: ./ssh-brute.sh <username> <path/to/wordlist.txt> <ip_adress> <speed>
     - speed changes the amount of login tries running at the same time
     - if speed isn't set, defaults to 5
```
I don't recommend going over speed 40, because it won't register loging in with higher speeds

## Example
```bash
./ssh-brute.sh administrator /home/kali/rockyou.txt 192.168.1.100
```
