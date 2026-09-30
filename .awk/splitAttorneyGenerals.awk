BEGIN {
    STATE = " of "
    lenSep = length(STATE) + 1
    }
{
    # - [Steve Marshall](https://www.alabamaag.gov/about/), [Attorney General](https://www.alabamaag.gov/) of [Alabama](https://www.alabama.gov/)
    line = substr($0, 3)
    lenLine = length(line)
    comma = index(line, ", ")
    stateSep = index(line, STATE)
    # printf("#DEBUG: line=%s\nlenLine=%d, comma=%d, stateSep=%d\n", line, lenLine, comma, stateSep)
    if ((comma * stateSep) > 0) {
        name = substr(line, 1, comma - 1)
        title = substr(line, comma + 2, stateSep - comma - 1)
        state = substr(line, stateSep + lenSep - 1)
        printf("- %s\n    - %s\n        - %s\n", state, title, name)

        }
    }