BEGIN {
    FS = ":"
    }
{ printf("IndexName[\"%s\"] = \"%s\"\n", $1, $2) }