BEGIN {
  FS = "|"
  PHONE = 2
  LOCATION  = 3
  DATETIME = 4
  CALLER = 5
  SOCIALMEDIA = 6
  NANPA = "+1"
  LINK = "<a href=\"tel:+1"
  }
{ if (index($0, NANPA) > 0) {
    #printf("DEBUG: %s\n", $PHONE)
    start = index($PHONE, NANPA)
    raw = substr($PHONE, start + 2, 10)
    areacode = "(" substr($PHONE, start + 2, 3) ") "
    exchange = substr($PHONE, start + 5, 3)
    subscriber = substr($PHONE, start + 8, 4)
    $PHONE = areacode exchange "-" subscriber
    $PHONE = raw
    #printf("DEBUG: $PHONE=%s\n", $PHONE)
    }
  link = "| " linkTele($PHONE)
  #printf("%s\n", $0)
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
