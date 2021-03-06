#!/bin/bash
#
# Bootstrap to initialize system

# obtain sudo privilege
dummy=$(sudo whoami)
umask 022

# generate log
RANDOM=$$
LOGFILE="$(pwd)/setup.$RANDOM.log"
exec >& >(tee "$LOGFILE")

# install git
echo -e "\e[1m[bootstrap] \e[0m\e[96mupdate system\e[0m"
tput smcup
sudo apt update
sudo apt dist-upgrade -y
sudo apt install -y git
tput rmcup

# pull whole setup repo
echo -e "\e[1m[bootstrap] \e[0m\e[96mclone repo\e[0m"
# remove ubuntu-setup if exists
rm -rf ubuntu-setup
git clone https://github.com/johnmave126/ubuntu-setup.git

# run actual setup script
pushd ubuntu-setup >/dev/null
echo -e "\e[1m[bootstrap] \e[0m\e[96mstart actual setup\e[0m"
./setup.sh
popd >/dev/null

echo -e "\e[1m[bootstrap] \e[0m\e[96mfinished, log written to $LOGFILE\e[0m"
