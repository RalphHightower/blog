#! /bin/bash

cat calls.md | awk -f telLink.awk | awk -f timeStamp.awk | sort -t@ +0r -1 +1 | awk -f rmTimestamp.awk | tee ns.md