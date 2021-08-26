#!/bin/sh
help (){
  echo "Usage:"
  echo " camera_test.sh <device-name> <video-capture-duration-in-seconds>"
  exit 1
}
if [ $# -ne 2 ];then
  help
else
  DUT="$1"
  DURATION=$2
  TIME=$(($DURATION * 3))
fi

RESOURCE=$(ebf $DUT get-resource camera)
if [ $? -eq 0 ];then
  echo "Start Capturing Video"
  VIDEO_ID=$(ebf $RESOURCE camera start-capture -d $DURATION)
  if [ $? -eq 0 ];then
    echo "Rebooting the Board"
    ebf raspbian power reboot
    if [ $? -eq 0 ];then
      # put sleep 3 times of total recording duration as ffmpeg takes this much time to complete the operation
      sleep "$TIME"s
      VIDEO_URL=$(ebf $RESOURCE camera get-ref $VIDEO_ID)
      echo ""
      echo "VIDEO_URL=$VIDEO_URL"
      echo ""
    else
      echo "Couldn't reboot the board"
      exit 1
    fi
  else
    echo "Couldn't start video capturing"
    exit 1
  fi
else
  echo "Couldn't get camera resource for video capturing"
  exit 1
fi
