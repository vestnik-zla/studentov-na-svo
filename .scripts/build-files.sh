#!/bin/bash

PREAMBLE_FILE=".templates/preamble.md"

PREAMBLE=$(cat "$PREAMBLE_FILE")

find . -type f -name "*.md" \
    ! -path "./.templates/*" \
    ! -name "README.md" | while read -r file; do

    echo "Processing $file"

    sed -i '/<!-- PREAMBLE START -->/,/<!-- PREAMBLE END -->/d' "$file"

    tmpfile=$(mktemp)

    {
        echo "$PREAMBLE"
        cat "$file"
    } > "$tmpfile"

    mv "$tmpfile" "$file"

done
