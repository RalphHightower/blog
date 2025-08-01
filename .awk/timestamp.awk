# second stage of nuisance calls formatting. This adds a sort key for sorting. 
# usage: cat YYYY-MM-DD.md | awk -f telLink.awk | awk -f timestamp.awk | sort -t@ +0r -1 +1 | awk -f rmTimestamp.md | tee new.md
# edit formatted file to remove sort key: ^.*@
BEGIN {
  FS = "|"
  DATETIME = 4
  }
{ 
  dt = $DATETIME 
  if (substr(dt, 1, 1) == " ")
    dt = substr(dt, 2)
  if (substr(dt, length(dt), 1) == " ")
    dt = substr(dt, 1, length(dt) - 1)
  cntdt = split(dt, parts, " ")
  date = parts[1]
  time = parts[2]
  noon = toupper(parts[3])
  cnttm = split(time, clock, ":")
  hour = clock[1]
  if ((noon == "PM") && (hour < 12))
    hour += 12
  timestamp = sprintf("%s %02d:%s", date, hour, clock[2])
  printf("%s@%s\n", timestamp, $0)
  }
