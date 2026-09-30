#!/bin/bash
module=mirrorwitchs-magiskal-fonts
basedir="$(realpath $(dirname $0)/..)"
zipfile="$module.zip"

set -e
cd "$basedir"
if ! [ -f "$zipfile" ]; then
    ./bin/make-zip.sh
    ls -lh "$zipfile"
fi
adb push "$zipfile" "/sdcard/$zipfile"
adb root
adb shell magisk --install-module "/sdcard/$zipfile"
adb shell rm "/sdcard/$zipfile"
rm "$zipfile"
echo "Now do:"
echo "adb reboot"
