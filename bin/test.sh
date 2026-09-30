#!/bin/bash
set -e
module=mirrorwitchs-magiskal-fonts
basedir="$(realpath $(dirname $0)/..)"
moduledir="$basedir/$module"
fontsxml_old="$basedir/info/fonts.xml.orig"
fontsxml_new="$moduledir/system/etc/fonts.xml"
fontsdir="$moduledir/system/fonts"

set -e
xmllint --noout "$fontsxml_old"
xmllint --noout "$fontsxml_new"
# :>
for font in $( diff -u "$fontsxml_old" "$fontsxml_new" | sed -n -e 's,^+[^>]*>,,p' | sed -e 's,<.*,,' | sort -u | grep -v '^ *$' )
do
    ls -lh "$fontsdir/$font"
done
