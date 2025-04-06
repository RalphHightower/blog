# Used to format Market Indexes from Google [Stock Market Indexes - Google Finance](https://www.google.com/finance/markets/indexes/)
# edit file to add 》 at start of regional markets
BEGIN {
  printf("| Index | Closing Value | Gain/Loss | Percentage Change |\n")
  printf("|---|---:|---:|---:|\n")
  }
{
  #printf("DEBUG: line=%d\n", line)
  if (substr($0, 1, 1) == "》") {
    line = -1
    }
  else if (line == -1) {
    if (substr($0, 1, 5) != "Index")
      printf("| **%s** | | | |\n", $0)
    }
  if (substr($0, 1, 5) == "Index") {
    line = 0
    }
  else if (line == 0) {
        printf("| %s ", $0) # Name
        line ++
      }
    else if (line == 1) {
      printf("| %s ", $0) # Value
      line ++
      }
   else if (line == 2) {
      printf("| %s ", $0) # Change
      direction = substr($0, 1, 1)
      arrow = (direction == "-" ? ":arrow_down:" : ":arrow_up:")
      line ++
      }
    else if (line == 3) {
      printf("| %s %s |\n", arrow, $0)
      line ++
    }
  }