#!/bin/bash

# Check if at least one filename is provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 file1.md [file2.md ...]"
    exit 1
fi

# Process each file
for file in "$@"; do
    awk -f extractLinks.awk "$file" -k |
        awk -f addWebSortKeys.awk |
        sort -t$ +0 -2 |
        awk -f removeWebSortKeys.awk
done | tee keywords.md