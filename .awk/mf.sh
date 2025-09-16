#!/bin/bash

DATE=`date +%F`
export DATE
FILEDATE=`date +%F | sed s/-//g`
export FILEDATE
TIME=`date +%r`
export TIME
FILENAME=`echo $DATE-$FILEDATE`ClosingIndexes.md
export FILENAME
cat ClosingIndexes.md | awk -f marketFormat.awk | 
 tee $FILENAME 

