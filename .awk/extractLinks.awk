# Extract links from GitHub Markdown files
# Input: Markdown file 
# Output: Links 
# @RalphHightower 
BEGIN {
    keywordExtract = 0
    extractLinks = 1
    for (ndx = 0; ndx <= ARGC; ndx ++) {
        printf("#DEBUG000: ARGV[%d]=\"%s\"\n", ndx, ARGV[ndx])
        if (ARGV[ndx] == "-k") {
            keywordExtract = 1
            extractLinks = 0
            ARGV[ndx] = ""
            }
        }
    # https is standard use, except Russian websites are not
    HTTP = "(http"
        news = ".abcnews.go.com/|ABC News - Breaking News, Latest News and Videos:.axios.com/|Axios - Breaking news, U.S. news and politics, and local news:.bbc.com/|BBC - Breaking News, World News, US News, Sports, Business, Innovation, Climate, Culture, Travel, Video & Audio:.bhphotovideo.com/explora/|B&H eXplora:.bhphotovideo.com/find/EventSpace.jsp|BH Photo Video / Event Space:.bloomberg.com/|Bloomberg - Business News, Stock Markets, Finance, Breaking & World News:.bloomberglaw.com|Bloomberg Law - Legal Research Software:.businessinsider.com/|Business Insider (BI) - Latest News in Tech, Markets, Economy & Innovation:.cbs.com|CBS TV Network Primetime, Daytime, Late Night and Classic Television Shows:.cbsnews.com/|CBS News / Breaking news, top stories & today's latest headlines:.cnbc.com/|CNBC - Stock Markets, Business News, Financials, Earnings:.cnn.com/|CNN / Breaking News, Latest News and Videos:.collectspace.com/|collectSPACE / where space exploration meets pop culture:.computerworld.com/Computerworld:.courtlistener.com/|Non-Profit Free Legal Search Engine and Alert System – CourtListener.com:.cybersecuritydive.com/|Cybersecurity Dive / Cybersecurity News and Analysis:.diyphotography.net/|DIYPhotography - Your one stop shop for everything photo and video:.dpreview.com/|DPReview / Photography News, Gear Reviews & Community:.fitsnews.com/|FITSNews - Independent. Unapologetic.:.forbes.com/|Forbes:.foxbusiness.com/|Faux Business / Business News & Stock Quotes - Saving & Investing:.foxnews.com/|Faux News - Breaking News Updates / Latest News Headlines / Photos & News Videos:.ft.com/|Financial Times:.huffpost.com/|HuffPost - Breaking News, Politics, Entertainment & Opinion:.independent.co.uk/|The Independent / Latest news and features from US, UK and worldwide:.jeffgeerling.com/|Jeff Geerling:.keh.com/expert-advice/|KEH / Expert Advice:.lensrentals.com/blog/|Lensrentals Blog:.mediamatters.org/|Media Matters for America:.motherjones.com/|Mother Jones – Smart, fearless journalism:.ms.now/|MS NOW - Breaking News and News Today / Latest News:.msnbc.com/|MSNBC News - Breaking News and News Today / Latest News:.nbc.com/|NBC TV Network - Shows, Episodes, Schedule:.nbcnews.com/|NBC News - Breaking Headlines and Video Reports on World, U.S. and Local Angles / NBC News:.newsmax.com/|News Min:.newsweek.com/|Newsweek - News, Analysis, Politics, Business, Technology:.newyorker.com/|The New Yorker:.notus.org/|NOTUS - NOTUS — News of the United States:.npr.org/|NPR - Breaking News, Analysis, Music, Arts & Podcasts – NPR:.nytimes.com/|The New York Times (NYT) - Breaking News, US News, World News and Videos:.pbs.org/|PBS News – News, Analysis, Top Headlines, Live Coverage:.propublica.org/|ProPublica — Investigative Journalism and News in the Public Interest:.reuters.com/|Reuters / Breaking International News & Views:.rollingstone.com/|Rolling Stone – Music, Film, TV and Political News Coverage:.slrlounge.com/|SLR Lounge / Photography Tutorials:.space.com/|Space.com: NASA, Space Exploration and Astronomy News:.theatlantic.com/|The Atlantic:.thebulwark.com/|The Bulwark / Substack:.thedailybeast.com/|The Daily Beast / The Latest in Politics, Media & Entertainment News:.thedailybeast.com/|The Daily Beast – The Latest in Politics, Media & Entertainment News:.theguardian.com/|The Guardian – Latest news, sport and opinion:.tomshardware.com/|Tom's Hardware: For The Hardcore PC Enthusiast:.usa.canon.com/explore/canon-legends|Canon Legends:.usa.canon.com/learning/inspiration/canon-co-lab|Canon Co-Lab:.usa.canon.com/learning/inspiration/canon-creator|Canon Creator:.usa.canon.com/learning/inspiration/explorers-of-light|Canon Explorers of Light:.usa.canon.com/learning/inspiration|Canon U.S.A. Inspiration:.usa.canon.com/learning/training-articles/training-articles-list|Canon Training Articles - Tips & Tricks:.usa.canon.com/learning|Canon Learning Center:.usatoday.com/|USA TODAY - Breaking News and Latest News Today:.vanityfair.com/|Vanity Fair - Entertainment, Politics, and Fashion Newsr:.washingtonpost.com/|The Washington Post - Breaking news and latest headlines, U.S. news, world news, and video - The Washington Post:.wikipedia.org/|Wikipedia:.wired.com/|WIRED - The Latest in Technology, Science, Culture and Business:.workday.com/|Workday / The Enterprise AI Platform for HR, Finance, and IT:.wsj.com/|The Wall Street Journal (WSJ) - Breaking News, Business, Financial & Economic News, World News and Video:.yahoo.com/|Yahoo / Mail, Weather, Search, Politics, News, Finance, Sports & Videos:/abc.com/|ABC Network - ABC.com:/abcnews.com|ABC News - Breaking News, Latest News and Videos:/abcnews.go.com/|ABC News - Breaking News, Latest News and Video:/apnews.com/|Associated Press News (AP) - Breaking News, Latest Headlines and Videos / AP News:/arstechnica.com/Ars Technica - Serving the Technologist since 1998. News, reviews, and analysis.:/blogs.microsoft.com/|The Official Microsoft Blog:/fstoppers.com/|Fstoppers - Photography News, Gear Reviews, Tutorials & Community:/gizmodo.com/|Gizmodo / The Future Is Here:/newrepublic.com/|The New Republic:/news.gallup.com/|Gallup News / Nonpartisan Analysis of Critical Global Issues:/nypost.com/|New York Post – Breaking News, Top Headlines, Photos & Videos:/people.com/|People.com / Celebrity News, Exclusives, Photos and Videos:/petapixel.com/PetaPixel / Photography and Camera News, Reviews, and Inspiration:/politico.com/|POLITICO - Politics, Policy, Political News:/rollcall.com/|Roll Call:/substack.com/|Substack:/talkingpointsmemo.com/|TPM – Talking Points Memo - Breaking News and Analysis:/techcrunch.com/|TechCrunch / Startup and Technology News:/thehill.com/|The Hill - covering Congress, Politics, Political Campaigns and Capitol Hill:/time.com/|TIME / Current & Breaking News / National & World Updates:/visualstudio.microsoft.com/|Visual Studio: IDE and Code Editor for Software Development"
    cntNewsLinks = split(news, newsLinks, ":")
    #for (ndx = 1; ndx <= cntNewsLinks; ndx ++)
    #    printf("#00DEBUG: %d=%s\n", ndx, newsLinks[ndx])
    }
{ # 1
    if ((keywordExtract == 1) && (substr($0, 1, 4) == "----"))
    {
        extractLinks = 1
        printf("#DEBUG05: Capturing\n")
        }
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
                        #printf("#45DEBUG: %s=》%s《\n", link, newsMedia(link))
                        if (extractLinks == 1)
                            printf("%s\n", link)
                        reference = newsMedia(link)
                        if (link != reference) {
                            if (!(reference in PRINTED)) {
                                #printf("#47DEBUG: link=%s, reference=%s\n", link, reference)
                                if (index(reference, "https://link.ms") == 0) {
                                    if (extractLinks == 1)
                                        printf("- %s\n", reference)
                                        }
                                PRINTED[ reference ] = reference 
                                }
                            }
                        line = substr(line, rightParen + 0)
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
    
    #printf("#100DEBUG: length(%s)=%d, posProtocol=%d, posAddress=%d, protocol:《%s》\n",  display, length(display), posProtocol, posAddress, protocol)
    
    posNews = 0
    found = 0
    for (ndx = 1; (ndx <= cntNewsLinks) && (posNews == 0); ndx ++) { # 2
        
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
                found = 1
                } # 4
            } # 3
        } # 2
    if (found == 1) {
        if (!(display in FOUND)) {
            #printf("#160DEBUG\n")
            #printf("- %s\n", display)
            FOUND[ display ] = 1
            }
        }
    return(display)
    } # 1