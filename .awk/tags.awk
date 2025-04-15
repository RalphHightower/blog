BEGIN {
    printf("tags: [")
    }
{
    gsub(",", "")
    printf("%s%s", (NR > 1 ? ", " : ""), $0)
    }
END {
    printf("]\n")
    }