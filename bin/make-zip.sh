#!/bin/bash
set -e
module=mirrorwitchs-magiskal-fonts
basedir="$(realpath $(dirname $0)/..)"
moduledir="$basedir/$module"
zipfile="$module.zip"
fontsxml="$moduledir/system/etc/fonts.xml"

$basedir/bin/test.sh

cd "$basedir"
[ -f "$zipfile" ] && rm -v -f "$zipfile"
cd "$moduledir"
zip -r "$basedir/$zipfile" *
cd "$basedir"
zip "$basedir/$zipfile" README.md
zip "$basedir/$zipfile" LICENSE
