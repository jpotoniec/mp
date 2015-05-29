#!/bin/sh

SRC="$1"
DST="$2"
TMP=`mktemp tmp.XXXXXXXXXX.pdf`
TMP2=`mktemp tmp.XXXXXXXXXX.pdf`
OPT="-density 600"

convert -trim +repage $OPT "$SRC" "$TMP"
MAX=`identify $OPT -format '%w\n' "$TMP" |perl -e '$max=0; while(<STDIN>) { chomp; $max=$_ if($_>$max);} print "^".$max."x"'`
echo $MAX
PAGE=`identify $OPT -format '%wx%h\n' "$TMP"  |grep "$MAX" |head -n 1`
echo $PAGE
convert -set page "$PAGE" $OPT "$TMP" "$TMP2"
convert $OPT "$TMP2" "$DST"
rm -f "$TMP" "$TMP2"
