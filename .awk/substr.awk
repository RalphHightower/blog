{
    start = 850
    if (length($0) >= start)
        printf("%d: |%s|\n", NR, substr($0, start))
    }