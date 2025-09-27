###### 1). This program grabs the web address from a markdown article link as sort key two.
###### 2. Grabs the domain from the web address and adds the domain in reverse order as key one.
###### Example: bbc.co.uk becomes uk.co.bbc
###### sort by domain groups articles articles within a domain
###### sort by weblink may group articles
BEGIN {
    #rgxWebAddr = /(https?):\/\/([-.A-Za-z0-9])[.][a-zA-Z]{2,}(\/[-._/A-Za-z0-9 ]|%[0-9A-Fa-f]{2})/
}
{
    #printf("#10DEBUG: NR=%d, 》%s《\n", NR, $0)
    found = match($0, "https?://[-!$%&'*+,./;<=>@_~A-Za-z0-9?]*")
    
    #printf("#20DEBUG: RSTART=%d\tRLENGTH=%d\n", RSTART, RLENGTH)
    if ((RSTART > 0) && (RLENGTH > 0))
    {
            
        #printf("#30DEBUG: %d:%s\tlength=%d\n", NR, $0, length($0))
        webUrl = substr($0, RSTART, RLENGTH)
            
        #printf("#40DEBUG: substr(%s, %d, %d)='%s'\n", $0, RSTART,  RLENGTH, webUrl)

        cntParts = split(webUrl, webParts, "/")
        #printf("#50DEBUG: cntParts=%d:%s\n", cntParts, webUrl)
        if (cntParts > 0)
        {
            if (0)   # 1 for debug
            {
                for (ndx = 1; ndx <= cntParts; ndx ++)
                {
                    printf("60DEBUG: webParts[%d]=%s\n", ndx, webParts[ndx])
                }
            }
            domain = ""
            cntDomain = split(webParts[3], domainParts, ".")
            #printf("#70DEBUG: %s:cntDomain=%d\n", webParts[3], cntDomain)
            if (cntDomain > 0)
            {
                for (ndx = cntDomain; ndx > 0; ndx--)
                {
                    #printf("#80DEBUG: domainParts[%d]=%s\n", ndx, domainParts[ndx])
                    domain = domain domainParts[ndx] (ndx > 1 ? "." : "")
                }
            }
            recNum = sprintf("%d", NR)
            #printf("#90DEBUG: \nlength(%s)=%d\nlength(%s)=%d\nlength(%s)=%d\n", domain, length(domain), webUrl, length(webUrl), NR, length(recNum))
            # domain$weblink$recordNumber$substr$
            sortKey = sprintf("%s$%s$%s$", domain, webUrl, recNum)
            lenSortKey = length(sortKey)
        
            #printf("#100DEBUG: length(%s)=%d\n", sortKey, lenSortKey)
            
            #printf("#120DEBUG:\nsortKey=%s,\nlenSortKey=%s,\n$0=%s\n", sortKey, lenSortKey, $0)
            
            #printf("#130DEBUG: %s%d$%s\n", sortKey, lenSortKey, $0)
            printf("%s%d$%s\n", sortKey, lenSortKey, $0)
        }
    }
}
 
