#!/usr/bin/env bash

# Preliminary steps (void linux):
# sudo xbps-install -Su v4l2loopback wf-recorder
# (don't forget to reboot if new Kernel version was upgraded)
#

# Too lazy to autodetect active monitor resolution
WIDTH=3840
HEIGHT=2160


# Detect and load kernel module if needed
#lsmod | grep v4l2loopback \
#  && echo "Kernel module detected" \
#  || ( \
#    echo "Need to modprobe v4l2loopback kernel module, please authorize:" \
#    && sudo modprobe v4l2loopback \
#  )

# List devices and exit when run without args
#if [ -z "$1" ]; then
#  v4l2-ctl --list-devices
#  echo "Please rerun sharescreen with the device device path of the Dummy listed above"
#  echo "Ex: sharescreen /dev/video4"
#  exit 1
#fi

device=/dev/video42

# Let device timout to prevent device-busy errors
# v4l2-ctl -d $device -c timeout=3000 # unverified

# Set capabilities for device, so chrom*/webrtcvideocapturer.cc
# based software like discord is happy.
#
# https://gstreamer.freedesktop.org/documentation/video/video-format.html?gi-language=c#GstVideoFormat
# GST_VIDEO_FORMAT_YUY2 (4) – packed 4:2:2 YUV (Y0-U0-Y1-V0 Y2-U2-Y3-V2 Y4 ...)
# Suspicion that matching GST format is `YUY2` is further backed
# by output of `gst-device-monitor-1.0` and finding section of webcam hardware
# that's works in chosen software

recording () {
  v4l2loopback-ctl set-caps \
    "video/x-raw, format=YUY2, width=$2, height=$3" \
    $1 || \
    echo "WARN; Failed to set format, rmmod / modprobe to free device?"

##
# In case your v4l2loopback utility is a different version, from what I can
# dump, the significant commands my version executes is:
#
#   v4l2-ctl -d /dev/video4 -c keep_format=1
#   v4l2-ctl -d /dev/video4 -c sustain_framerate=1
#   gst-launch-1.0 videotestsrc num-buffers=1 '!' video/x-raw,format=YUY2,width=2560,height=1440 '!' v4l2sink device=/dev/video4
#

# Start screen-capture and dump the frames into chosen loopback-devices
  wf-recorder --muxer=v4l2 --file=$1 \
    -c rawvideo -x yuyv422 -p framerate=10 -p scale=1920x1080
}


PIDS=$(ps -ef | grep .bin/swayscrshare.sh | grep bash | grep -v grep | awk '{print $2}')
THIS=$(echo ${PIDS} | awk '{print $1}')

if [ $(echo ${PIDS} | wc -w) == 2 ]; then
  TITLE="Screencast started"
  MESSAGE="Successfully started screencast"
  notify-send -t 3000 "${TITLE}" "${MESSAGE}"
  recording ${device} ${WIDTH} ${HEIGHT}
#if [ wc -l ${PID} ]; then
#  kill -INT ${PID}
#  exit 0

else
  ~/.bin/killtree.sh "${THIS}" INT
  TITLE="Screencast stopped"
  MESSAGE="Successfully stopped screencast"
  notify-send -t 3000 "${TITLE}" "${MESSAGE}"
fi
