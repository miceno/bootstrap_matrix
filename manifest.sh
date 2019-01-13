#!/usr/bin/env bash

echo "# File crc32 crc32(crlf) size size(crlf)  or  R File"
cat MANIFEST.txt |
while read f;
do
FILE=themes/bootstrap_matrix/$(dirname $f)/$f
CRC=$(crc32 "$f");
SIZE="$(stat -f '%z' $f)"

printf "%s\t%d\t%d\t%d\t%d\n" "$FILE" "0x$CRC" "0x$CRC" "$SIZE" "$SIZE";

done
