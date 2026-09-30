#!/bin/bash
set -e
urllist=info/font-urls.list
basedir="$(realpath $(dirname $0)/..)"
cachedir="$basedir/cache"
module=mirrorwitchs-magiskal-fonts
moduledir="$basedir/$module"
fontsdir="$moduledir/system/fonts"

mkdir -p "$cachedir" "$fontsdir"
cd "$cachedir"
while read line; do
  # github seems to block wget less than curl?
  wget -c "$line"
  sleep 1
done < "$basedir/$urllist"
unzip -o NotoSansCJK.ttc.zip
if ls *|grep -q -F '[wdth,wght].'; then
    for dirtyname in *wdth,wght*.tt[fc]; do
        cleanname="$(echo "$dirtyname" | sed -e "s/.wdth,wght.//")";
        mv -v "$dirtyname" "$cleanname"
    done
fi
if ls *|grep -q '\.tt[fc]$'; then
  mv -f -u -v *.tt[fc] "$fontsdir"
fi
chmod 0644 "$fontsdir"/*
