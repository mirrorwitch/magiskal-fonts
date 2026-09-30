#!/bin/bash
set -e
basedir="$(realpath $(dirname $0)/..)"
cachedir="$basedir/cache"
module=mirrorwitchs-magiskal-fonts
moduledir="$basedir/$module"
fontsdir="$moduledir/system/fonts"
themefonts_dir="$moduledir/system/product/fonts"

fontlist="$basedir/info/fontlist.tsv"
themefontlist="$basedir/info/themefontlist.tsv"

function get_list()
{
    tsvfile="$1"
    destdir="$2"

    if ! [ -d "$destdir" ]; then
        echo "Error: Missing directory $destdir ."
        exit 2
    fi

    while read line; do
        filename="$(echo "$line" |cut -f 1)"
        url="$(echo "$line" |cut -f 2)"
        # github seems to block wget less than curl?
        wget -c "$url" -O "$filename"
        if file -i "$filename" | grep -q ':.*text/html'; then
            echo "ERROR: Got HTML page for: $url"
            echo "Blocked by host, or direct download URL incorrect."
            rm -v "$file"
            exit 1
        fi
        sleep 1
        chmod 0644 "$filename"
        cp -afuv "$filename" "$destdir/"
    done < "$tsvfile"
}

mkdir -p "$cachedir" "$fontsdir" "$themefonts_dir"
cd "$cachedir"
get_list "$fontlist" "$fontsdir"
get_list "$themefontlist" "$themefonts_dir"
