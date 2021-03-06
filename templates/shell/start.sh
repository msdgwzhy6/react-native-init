#!/usr/bin/env bash

port=$1
if [ -z "${port}" ]; then
  port=8081
fi

# Android emulator must be launched by yourself.
sh shell/launch-android.sh

data=`curl --silent http://localhost:${port}/status`
if [ "${data}" = "packager-status:running" ]; then
  echo "JS server already running."
else
  commandFile=$(dirname "$0")/start.command
  cat > ${commandFile} << EOF
cd "\$(dirname "$0")/.."
# Run 'react-native start --help' to get more parameters
node "./node_modules/.bin/react-native" start --port ${port}
EOF
  # Permission is required by system.
  chmod 0755 ${commandFile}
  open ${commandFile}
fi

react-native link
# Run android may fail before emulator boot complete.
react-native run-android --port ${port}
# You can change simulator as you like. Such as 'iPhone X', 'iPhone 6'.
react-native run-ios --simulator 'iPhone 8' --port ${port}
