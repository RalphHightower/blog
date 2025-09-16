BEGIN {
    FS = "|"
    TELE = 2
    LOCATION = 3
    }
{
    if (index($TELE, "+1 (") > 1) {
        exchange = substr($TELE, 7, 9)
        printf("%s:%s\n", exchange, $LOCATION)
        }
    }