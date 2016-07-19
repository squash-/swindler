#!/bin/bash
#
# Install script for swindler.
# Copyright 2016 (c) Johnathan Cintron

WORKINGDIR=$(pwd)

function isCheatInstalled() {
     if hash cheat 2>/dev/null; then
        return 1
     else
        return 0
     fi
}

function installCheatDeps() {
    pip install docopt pygments appdirs
}

if [ $EUID -ne 0 ]; then
   printf "Installtion aborted. Please run as root\n"
   exit
fi

if isCheatInstalled -ne 0; then
   printf "swindler requires cheat to be installed!!\n"
   printf "\n"
   read -p "Would you like to install cheat now? (y/N): " decision

   if [ $decision == "y" ] || [ $decision == "Y" ]; then
      # Download and unzip cheat to /tmp
      printf "Downloading and unzipping cheat...\n"
      wget https://github.com/chrisallenlane/cheat/archive/master.zip -O /tmp/cheat.zip
      unzip /tmp/cheat.zip -d /tmp
      # push the two working directories onto the stack
      pushd src
      pushd /tmp/cheat-master

      printf "Installing cheat's dependancies...\n"
      # Install cheat dependancies
      installCheatDeps

      printf "Installing cheat...\n"
      # Install cheat
      python setup.py install

      printf "Installing swindler...\n"
      #install swindler
      popd
      make install

      # clean up
      rm -f /tmp/cheat.zip && rm -rf /tmp/cheat-master

      # installation complete
      printf "swindler installed!\n"
      exit
   elif [ $decision == "n" ] || [ $decision == "N" ] || [ $decision == "" ]; then
      printf "Installation aborted.\n"
      exit
   fi
else
  printf "Installing swindler...\n"
  cd $WORKINGDIR && cd src
  make install
  printf "swindler installed!\n"
  exit
fi
