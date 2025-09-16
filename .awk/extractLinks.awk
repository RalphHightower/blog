# Extract links from GitHub Markdown files
# Input: Markdown file 
# Output: Links 
# @RalphHightower 
BEGIN {
    # https is standard use, except Russian websites are not
    HTTP = "(http"
        news = ".msnbc.com/|MSNBC News - Breaking News and News Today / Latest News:.nbcnews.com|NBC News - Breaking Headlines and Video Reports on World, U.S. and Local Angles / NBC News:.cbsnews.com/|CBS News / Breaking news, top stories & today's latest headlines:.abcnews.go.com/|ABC News - Breaking News, Latest News and Videos:.nytimes.com/|The New York Times (NYT) - Breaking News, US News, World News and Videos:.wsj.com/|The Wall Street Journal (WSJ) - Breaking News, Business, Financial & Economic News, World News and Video:.washingtonpost.com|The Washington Post - Breaking news and latest headlines, U.S. news, world news, and video - The Washington Post:.wired.com/|WIRED - The Latest in Technology, Science, Culture and Business:apnews.com/|Associated Press News (AP) - Breaking News, Latest Headlines and Videos / AP News:.reuters.com/|Reuters / Breaking International News & Views:.cnn.com|CNN / Breaking News, Latest News and Videos:.bbc.com/|BBC Home - Breaking News, World News, US News, Sports, Business, Innovation, Climate, Culture, Travel, Video & Audio:.bloomberg.com/|Bloomberg - Business News, Stock Markets, Finance, Breaking & World News:.time.com|Time:.businessinsider.com/|Business Insider:thehill.com/|The Hill - covering Congress, Politics, Political Campaigns and Capitol Hill:politico.com/|POLITICO - Politics, Policy, Political News:.thedailybeast.com/|The Daily Beast / The Latest in Politics, Media & Entertainment News:.theatlantic.com/|The Atlantic:.rollingstone.com|Rolling Stone – Music, Film, TV and Political News Coverage:rollcall.com/|Roll Call:.newsweek.com/|Newsweek - News, Analysis, Politics, Business, Technology:newrepublic.com/|The New Republic:.huffpost.com/|HuffPost - Breaking News, Politics, Entertainment & Opinion:.foxbusiness.com/|Faux Business:.theguardian.com|The Guardian – Latest news, sport and opinion:.yahoo.com|Yahoo / Mail, Weather, Search, Politics, News, Finance, Sports & Videos:.foxnews.com/|Faux News:.newsmax.com/|News Min:nypost.com|New York Post – Breaking News, Top Headlines, Photos & Videos"
    cntNewsLinks = split(news, newsLinks, ":")
    #for (ndx = 1; ndx <= cntNewsLinks; ndx ++)
        #printf("#00DEBUG: %s\n", newsLinks[ndx])
    }
{ # 1
    line = $0 "◇"
    https = index(line, HTTP)
    
    #printf("#10DEBUG: NR=%d, length(《%s》)=%d, https=%d\n", NR, line, length(line), https)

    if (https > 0) { # 2
    
        leftBracket = index(line, "[")
        rightBracket = (leftBracket > 0 ? index(substr(line, leftBracket), "](") + leftBracket : 0)
        
        #printf("#20DEBUG: leftBracket=%d, rightBracket=%d 《%s》, length=%d\n", leftBracket, rightBracket, ((leftBracket < rightBracket) ? substr(line, leftBracket, rightBracket - leftBracket) : ""), rightBracket - leftBracket)
        
        if (substr(line, rightBracket + 1, length(HTTPS)) == HTTPS) { # 3
            leftParen = rightBracket + 0
            rightParen = (leftParen > 0 ? index(substr(line, leftParen), ")") + leftParen : 0)
            
            #printf("#30DEBUG: leftParen=%d, rightParen=%d 《%s》, length=%d\n", leftParen, rightParen, ((leftParen * rightParen) > 0 ? substr(line, leftParen, rightParen - leftParen) : ""), rightParen - leftParen)
            
            while (https * (leftBracket * rightBracket) * (leftParen * rightParen) > 0) { # 4
                
                #printf("#40DEBUG: leftBracket=%d rightBracket=%d, leftParen=%d, rightParen=%d\n", leftBracket, rightBracket, leftParen, rightParen)
                
                if (rightBracket > leftBracket) { # 5
                    if (substr(line, leftBracket + 1, 1) != "^") { # 6
                        link = substr(line, leftBracket, rightParen - leftBracket)
                        #printf("#45DEBUG: 》%s《\n", newsMedia(link))
                        printf("%s\n", link)
                        reference = newsMedia(link)
                        if (link != reference)
                            printf("- %s\n", reference)
                        line = substr(line, rightParen + 1)
                        https = index(line, HTTP)
                        
                        #printf("#50DEBUG\nTRIMMING: length(《%s》)=%d, https=%d\n", line, length(line), https)
                        
                        } # 6
                    else { # 6
                        # footnote
                        line = substr(line, rightBracket + 1)
                        
                        #printf("#55DEBUG: length(《%s》)=%d\n", line, length(line))
                        
                        } # 6
                    } # 5

                leftBracket = index(line, "[")
                rightBracket = (leftBracket > 0 ? index(substr(line, leftBracket), "](") : 0) + leftBracket 
                
                #printf("#60DEBUG: leftBracket=%d, rightBracket=%d 《%s》, length=%d\n", leftBracket, rightBracket, ((leftBracket < rightBracket) ? substr(line, leftBracket, rightBracket - leftBracket) : ""), rightBracket - leftBracket)

                leftParen = rightBracket + 0
                rightParen = (leftParen > 0 ? index(substr(line, leftParen), ")") + leftParen : 0)
                
                #printf("#70DEBUG: leftParen=%d, rightParen=%d 《%s》, length=%d\n", leftParen, rightParen, ((leftParen < rightParen) ? substr(line, leftParen, rightParen - leftParen) : ""), rightParen - leftParen)
                
                https = index(line, HTTP)
                #printf("#57DEBUG: NR=%d, length(《%s》)=%d, https=%d\n", NR, line, length(line), https)
                } # 4
            } # 3
        else { # 3
            line = substr(line, rightBracket + 1)
            
            #printf("#58DEBUG: length(《%s》)=%d\n", line, length(line))
            
            } # 3
        } # 2
    } # 1

function newsMedia(markdownLink) { # 1
    display = markdownLink 
    posProtocol = index(display, "(http")
    posAddress = index(display, "://") + 3
    protocol = substr(display, posProtocol, posAddress - posProtocol)
    
    #printf("#100DEBUG: length(display)=%d, posProtocol=%d, posAddress=%d, protocol:《%s》\n",  display, length(display), posProtocol, posAddress, protocol)
    
    posNews = 0
    for (ndx = 1; (ndx < cntNewsLinks) && (posNews == 0); ndx ++) { # 2
        
        #printf("#110DEBUG: newsLinks[%d]=%s\n", ndx, newsLinks[ndx])

        pipeSplit = index(newsLinks[ndx], "|")
        
        #printf("#120DEBUG: pipeSplit=%d\n", pipeSplit)
        
        if (pipeSplit > 0) { # 3
            domain = substr(newsLinks[ndx], 1, pipeSplit - 1)
            
            #printf("#130DEBUG: domain=《%s》, name=《%s》\n", domain, name)
                        
            posNews = index(display, domain)
            
            #printf("#140DEBUG: posNews=%d\n", posNews)
            
            if (posNews > 0) { # 4
                cntAddress = split(substr(display, posProtocol), addressParts, "/")
                if (cntAddress >= 3) { # 5
                    name = "[" substr(newsLinks[ndx], pipeSplit + 1) "]"
                    address = addressParts[1] "//" addressParts[3] "/)"
                    display = name address
                    for (parts = 1; parts <= cntAddress; parts ++) { # 6
                        #printf("#150DEBUG: addressParts[%d]=《%s》\n", parts, addressParts[parts])
                        } # 6
                    } # 5
                } # 4
            } # 3
        } # 2
    return(display)
    } # 1