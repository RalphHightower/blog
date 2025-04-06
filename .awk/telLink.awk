# First step to format telephone log file. This formats telephone numbers to a linkable format for html files 
BEGIN {
  FS = "|"
  PHONE = 1
  LOCATION  = 2
  DATETIME = 3
  CALLER = 4
  SOCIALMEDIA = 5
  }
{
  link = "| " linkTele($PHONE)
  dt = $DATETIME 
  if (substr(dt, 1, 1) == " ")
    dt = substr(dt, 2)
  if (substr(dt, length(dt), 1) == " ")
    dt = substr(dt, 1, length(dt) - 1)
  cntdt = split(dt, parts, " ")
  date = parts[1]
  time = parts[2]
  noon = toupper(parts[3])
  voiceMail = (cntdt > 3 ? " " parts[4] : "")
  $DATETIME = date " " (length(time) == 5 ? time : "0" time) " " noon voiceMail
  for (ndx = LOCATION; ndx <= SOCIALMEDIA; ndx++) {
    if (ndx <= NF)
      link = link " | " $ndx
    else
      link = link " | "
    }
  link = link " |"
  gsub(" [ ]*", " ", link)
  printf("%s\n", link)
  }

function linkTele(phone) {
  #printf("DEBUG: len(%s)=%d\n", phone, length(phone))
  gsub("[ ]*", "", phone)
  lenPhone = length(phone)
  #printf("DEBUG: len(%s)=%d\n", phone, lenPhone)
  link = "<a href=\"tel:" 
  fmtPhone = ""
  offset = (lenPhone == 10 ? 0 : 1)
  switch (lenPhone) {
    case 10:
      fmtPhone = "(" substr(phone, 1, 3) ") " substr(phone, 4, 3) "-" substr(phone, 7, 4)
      retVal = link "+1" phone "\">+1 " fmtPhone "</a>"
      break;
    case 11:
      fmtPhone = "+" substr(phone, 1, 1) " (" substr(phone, 2, 3) ") " substr(phone, 5, 3) "-" substr(phone, 8, 4)
      retVal = link phone "\">+1 " fmtPhone "</a>"
      break;
    case 12:
      fmtPhone = substr(phone, 1, 2) " (" substr(phone, 3, 3) ") " substr(phone, 6, 3) "-" substr(phone, 9, 4)
      retVal = link phone "\">+1 " fmtPhone "</a>"
      break;
        default:
        retVal = phone
      }
    #printf("DEBUG: lenPhone=%d:fmtPhone=%s\n", lenPhone, fmtPhone)
    gsub("  [ ]*", "", retVal)
    return (retVal)
  }