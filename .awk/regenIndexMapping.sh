cp watchList.md wl.md
cat wl.md |
sort -t: +3n -4 +0 -1 | tee watwatchList.md | awk -f mapSymbol2ETF.awk | tee IndexName.md
