#!/data/data/com.termux/files/usr/bin/bash

DATE=`date +%F`
#DATE=2026-07-23
#DATE=2026-07-24
#DATE=2026-07-27
#DATE=2026-07-28
#DATE=2026-07-29
#DATE=2026-07-30
#DATE=2026-07-31
export DATE
FILEDATE=`echo $DATE | sed s/-//g`
export FILEDATE
TIME=`date +%r`
export TIME
FILENAME=`echo $DATE-$FILEDATE`ClosingIndexes.md
export FILENAME
echo $FILENAME 

mkdir -p $DATE

if ! test -f $DATE/portfolio.csv;
then {
    # cp ~/storage/downloads/portfolio*.csv $DATE
    mv ~/storage/downloads/portfolio*.csv $DATE
    # awk -f marketFormatYahoo.awk $(ls "$DATE"/portfolio*.csv | sort -V)
    }
fi
    
if test -f $DATE/portfolio.csv;
then {
    files=()
    while IFS= read -r f; do
        files+=("$f")
    done < <(ls "$DATE"/portfolio*.csv | sort -V)
    
    awk -f marketFormatYahoo.awk "${files[@]}" | tee $FILENAME
    # rm ~/storage/downloads/portfolio*.csv
    }
else {
    echo No files!
    }
fi
