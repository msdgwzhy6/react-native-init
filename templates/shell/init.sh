#!/usr/bin/env bash

# This file is for team cooperation.
# Everyone must run this file at first.
# sh shell/init.sh

# Your team should use the same tool to install packages.
# That dependencies on the project creator.
:install:

# Required by ios
# Downloading rncache can be fail easily, so we just copy it.
# See react-native/src/rncache.json
mkdir -p ~/.rncache
cp -f rncache/* ~/.rncache/

# Required by android
ANDROID_PATH_EXIST=`cat ~/.bash_profile | grep ANDROID_HOME=`
if [ -z "$ANDROID_PATH_EXIST" ]; then
  echo '

    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/tools/bin
    export PATH=$PATH:$ANDROID_HOME/platform-tools

  ' >> ~/.bash_profile

  source $HOME/.bash_profile
fi

# Required by android
# Install sdk
# User may not install Android Studio
if [ ! -f "${ANDROID_HOME}/tools/bin/sdkmanager" ]; then
  echo ""
  echo "Downloading android sdk tools..."
  echo ""
  sdk_tools_url=`curl https://developer.android.google.cn/studio/ | egrep -o "https://dl.google.com/android/repository/sdk-tools-darwin-.+?\.zip"`
  sdk_tools_name=`basename ${sdk_tools_url}`
  sdk_tools_dir=$HOME/react-native-cli-${sdk_tools_name%%.*}
  sdk_tools_archive=${sdk_tools_dir}/${sdk_tools_name}

  if [ ! -f "$sdk_tools_archive" ]; then
    mkdir -p ${sdk_tools_dir}
    curl -o ${sdk_tools_archive} ${sdk_tools_url}
  fi

  mkdir -p  ${ANDROID_HOME}
  tar -zxvf ${sdk_tools_archive} -C ${ANDROID_HOME}
fi

# This file may not exist.
touch $HOME/.android/repositories.cfg
# Accept all the licences, so the program will not ask again.
yes | sdkmanager --licenses
sdkmanager :sdk_platforms:
sdkmanager :sdk_tools:

# Required by android
# Install or update emulator tool
sdkmanager --install emulator
# Create emulator.
sh shell/create-android-emulator.sh

echo ''
echo '\033[33mInitialize Complete.\033[0m'
echo ''
