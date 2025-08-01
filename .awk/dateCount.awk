BEGIN {
    FS = "|"
    DATETIME = 4
    }
{ datePos = index($DATETIME, "202")
    if (datePos > 0) {
        key = substr($DATETIME, datePos, 10)
        dates[ key ] ++
        }
    }
END {
    for (key in dates)
        printf("%d,%s\n", dates[ key ], key)
    }
