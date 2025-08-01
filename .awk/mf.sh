#!/bin/bash

DATE=`date +%F`
TIME=`date +%r`

cat ClosingIndexes.md | awk -f marketFormat.awk

