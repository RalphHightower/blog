BEGIN {
    FS = ","
    }
{
    for (ndx = 1; ndx <= NF; ndx ++)
        printf("%s\n", $ndx)
    }