BEGIN {
    FS = "|"
    FLD_PHONE = 2
    lnkBegin = "<a href=\"" # tel: will follow
    lenBgnLink = length(lnkBegin)
    lnkEnd = "\">"
    lenLnkEnd = length(lnkEnd)
    fmtBegin = "\">"
    lenBgnFmt = length(fmtBegin)
    fmtEnd = "</a>"
    lenFmtEnd = length(fmtEnd)
    #printf("#DEBUG: %d, %d\n", lenBgnLink, lenLnkEnd)
    #printf("#DEBUG: %d, %d\n", lenBgnFmt, lenFmtEnd)
    strLink = "<a href=\"tel:+18036674326\">"
    #printf("#DEBUG: length(%s)=%d\n", strLink, length(strLink))
    newLink = "tel:+18033300553"
    #printf("#DEBUG: length(%s)=%d\n", newLink, length(newLink))
    strDisplay = "\">+1 (803) 667-4326</a>"
    #printf("#DEBUG: length(%s)=%d\n", strDisplay, length(strDisplay))
    newDisplay = "+1 (803) 667-4326"
    #printf("#DEBUG: length(%s)=%d\n", newDisplay, length(newDisplay))
    }
{
    posLnkBgn = index($FLD_PHONE, lnkBegin)
    posLnkEnd = index($FLD_PHONE, lnkEnd)
    posFmtBgn = index($FLD_PHONE, fmtBegin)
    posFmtEnd = index($FLD_PHONE, fmtEnd)
    
    # easy way to determine if all strings are found; if any are not found, the result will be 0
    process = posLnkBgn * posLnkEnd * posFmtBgn * posFmtEnd
    if (process == 0)
        printf("%s\n", $0)
    else {
        newFormat = reformat($FLD_PHONE, posLnkBgn, posLnkEnd, posFmtBgn, posFmtEnd)
        printf("| %s |", newFormat)
        for (ndx = FLD_PHONE + 1; ndx < NF; ndx ++) {
            printf("%s|", $ndx)
            }
        printf("\n")
        }
    }
    
function reformat(phone, bgnLink, endLink, bgnDisplay, endDisplay) {
    #printf("#DEBUG: |%s|=%d, %d, %d, %d, %d\n", phone, length(phone), bgnLink, endLink, bgnDisplay, endDisplay)
    startLink = bgnLink + lenBgnLink
    link = substr(phone, startLink, endLink - startLink)
    startDisplay = bgnDisplay + lenBgnFmt
    display = substr(phone, startDisplay, endDisplay - startDisplay)
    newFormart = "[\\" display "](" link ")"
    return(newFormart)
    }
