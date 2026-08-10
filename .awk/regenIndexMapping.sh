cp watchList.md wl.md
cat wl.md |
sort -t: +3n -4 +1f -2 | tee watchList.md | awk -f mapSymbol2ETF.awk | tee IndexName.md
