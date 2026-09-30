awk -F '|' '
NR>1 {
    gsub(/^[ \t]+|[ \t]+$/, "", $3)
    loc[$3]++
}
END {
    for (l in loc) {
        printf "%d@%s\n", loc[l], l
    }
}
' blog/NuisanceTelephoneCalls.md | sort -t@ +0nr -1 +1 -2