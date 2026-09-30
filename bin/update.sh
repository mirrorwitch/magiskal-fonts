#!/bin/bash
set -e
urllist=info/font-urls.list
basedir="$(realpath $(dirname $0)/..)"
cachedir="$basedir/cache"
module=mirrorwitchs-magiskal-fonts
moduledir="$basedir/$module"
fontsdir="$moduledir/system/fonts"
themefonts="Bitter.ttf Bitter-Italic.ttf ShantellSans.ttf"
themefonts_dir="$moduledir/system/product/fonts"

mkdir -p "$cachedir" "$fontsdir" "$themefonts_dir"
cd "$cachedir"
while read line; do
  # github seems to block wget less than curl?
  wget -c "$line"
  if file -i * | grep -q ':.*text/html'; then
      echo "ERROR: Got HTML page for: $line"
      echo "Blocked by host, or direct download URL incorrect."
      rm -v $(file -i *|grep ':.*text/html'|cut -d : -f 1)
      exit 1
  fi
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
  chmod 0644 "$filename"
  cp -afuv "$filename" "$fontsdir/"
done

# TODO: better way
for filename in $themefonts; do
    if [ -f "$filename" ]; then
        cp -afuv "$filename" "$themefonts_dir/"
    fi
done
