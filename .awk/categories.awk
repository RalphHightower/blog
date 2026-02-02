# Part 2 to create a unified Jekyll categories for s group of posts
# cat categories-p.md | sort -ut: +1 -2 | sort -t: +0n -1 | awk -f categories.awk
BEGIN {
    FS = ":"
    printf("categories: [")
    }
{ #printf("#00DEBUG: NR: %d\n", NR)
    if (NR == 1)
        printf("%s", $2)
    else
        printf(",%s", $2)
    }
END {
    printf("]\n")
    }