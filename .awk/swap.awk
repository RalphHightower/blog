BEGIN {
  FS = "|"
  PHONE = 2
  LOCATION  = 3
  DATETIME = 4
  CALLER = 5
  SOCIALMEDIA = 6
  }
{ 
  $PHONE = trim($PHONE) 
  $LOCATION = trim($LOCATION) 
  $DATETIME = trim($DATETIME) 
  $CALLER = trim($CALLER)
  $SOCIALMEDIA = trim($SOCIALMEDIA)
  #for(ndx = PHONE; ndx <= SOCIALMEDIA; ndx++)
  #  printf("DEBUG: $%d=%s\n", ndx, $ndx)
  #printf("DEBUG: CALLER=%s, LOCATION=%s, DATETIME=%s, CALLER=%s\n", $PHONE, $LOCATION, $DATETIME, $CALLER)
  loc = $LOCATION 
  len = length(loc)
  #printf("DEBUG %d: %s=%d\n", NR, loc, len)
  if (NF >= SOCIALMEDIA) {
      #printf("DEBUG: location=%s\tdate=%s\n", $LOCATION, $DATETIME)
      year = substr(loc, 1, (len >= 5 ? 5 : len))
      #printf("\nDEBUG %d: year=%s\n\n", NR, year)
      yf = index("2025-|2024-|2023-", year)
      #printf("DEBUG: yf=%d\n", yf)
      if (yf > 0 ) {
        temp = $DATETIME 
        $DATETIME = $LOCATION 
        $LOCATION = temp
        }
     }
  line = "| "
  for(ndx = PHONE; ndx <= SOCIALMEDIA; ndx++) {
    #printf("DEBUG: $%d=%s\n", ndx, $ndx)
    line = line $ndx (ndx < SOCIALMEDIA ? " | " : " |")
    }
  #printf("DEBUG: output below \n")
  # line = "|" $PHONE "|" $DATETIIME "|" $LOCATION "|" $CALLER "|" $SOCIALMEDIA "|"
  printf("%s\n", line) 
  }

function trim(str) {
  if (substr(str, 1, 1) == " ")
    str = substr(str, 2)
  if (substr(str, length(str), 1) == " ")
    str = substr(str, 1, length(str) - 1)
  gsub("  [ ]*", "", str)
  return(str)
  }