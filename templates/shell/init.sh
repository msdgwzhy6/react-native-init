#!/usr/bin/env bash

# Install shell is for team cooperation. Everyone must run this file at first.
# sh shell/init.sh

:install:

mkdir -p ~/.rncache
cp -f rncache/* ~/.rncache/

ANDROID_PATH_EXIST=`cat ~/.bash_profile | grep ANDROID_HOME=`

if [ "$ANDROID_PATH_EXIST" == "" ]; then
  echo '

    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/tools/bin
    export PATH=$PATH:$ANDROID_HOME/platform-tools

  ' >> ~/.bash_profile

  source $HOME/.bash_profile
fi

echo ''
echo '\033[33mInitialize Complete.\033[0m'
echo ''
