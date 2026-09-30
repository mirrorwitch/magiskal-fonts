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
if ls *|grep '\.zip$'; then
    for zipfile in *.zip; do
        unzip -o "$zipfile" # && rm "$zipfile"
    done
fi

# remove any name component like "[foo,bar]", used in variable fonts by google
if ls -d *|grep -q '\[.*\]'; then
    for dirtyname in *\[*\]*; do
        cleanname="$(echo "$dirtyname" | sed -e "s/\[[^]]*\]//")"
        cp -f -u -v "$dirtyname" "$cleanname"
    done
fi
for filename in $(ls *.*|grep -vF '[' | grep '\.tt[fc]$'); do
  cp -f -u -v "$filename" "$fontsdir/"
done
chmod 0644 "$fontsdir"/*
