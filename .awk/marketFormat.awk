# Used to format Market Indexes from Google Finance
# I haven't been able to pass date and time as parameters, but passing DATE. TIME as environment variables works

BEGIN {

    cur_date = ""
    cur_time = ""
    mktAmericas = ""
    mktEurope = ""
    mktAsia = ""
    # add new sector variable to hold the region's performance assessment 
    mktDefense = "no data"
    mktEnergy = "no data"
    
    DUMP = "Your watchlist in the news"

    #
    # adding <sector> ETFs
    # 1. add <> ETF symbols 
    #
    etfDefenseSymbols = "ARKQ,ARKX,DFEN,DFNS,EUAD,FITE,GCAD,IDEF,ITA,JEDI,KDEF,MISL,NATO,PPA,SHLD,UFO,WAR,WDAF,WDEF,WDGF,XAR|"
    etfEnergySymbols = "|AMLP|AMZA|BNO|BOIL|BWET|CCNR|CRAK|CSNR|DBO|DIG|DRIP|DUG|EINC|EIPI|EMLP|ENFR|ERX|ERY|FCG|FENY|FENY|FTRI|FTXN|FUTY|FXU|GII|GNR|GUNR|GUSH|IDU|IEO|IEZ|IFRA|IGF|IXC|IYE|JXI|KOLD|MLPX|NANR|NFRA|NLR|NRGD|NRGU|OIH|OILK|OILT|OILU|PSCE|PUI|PXE|PXI|PXJ|RBLD|RSPG|RSPU|SCO|TEXU|TOLZ|TPYP|UCO|UGA|UMI|UNG|UPW|URA|URNM|USAI|USL|USO|USOY|UTES|UTSL|VDE|VPU|XES|XLE|XLU|XOP|"

    etfCustomLists = etfDefenseSymbols etfEnergySymbols

    regionCount = 0

    #
    # Add the new <sector> name
    #
    region = "|Americas|Europe, Middle East, and Africa|Asia Pacific|Defense ETFs|Energy ETFs|"
    cntRegions = split(region, regBreaks, "|")
 
    # Use associative arrays to hold the region's assessment
    for (ndx = 1; ndx <= cntRegions; ndx ++) {
        if (regBreaks[ndx] != "") {
            regionAssessment[regBreaks[ndx]] = "no data"
            }
        }
    #

    # add <sector> Watch list name to check if a new sector is encountered 
    #
    customETF = "|Defense ETFs|Energy ETFs|"

    gainers = 0
    losers = 0
    pctChange = 0.0
    line = -1
    prevRegion = ""
    currRegion = ""
    tableHeader = "Americas"
    postHeader()
    }

{ # 1
    cntSub = gsub(/\$/, "")
    if (index($0, "youtube_trending") > 0)
        next
    curLine = $0
    
    currRegion = index(region, curLine)
    if (currRegion > 0)
        dump = 0
    
    dumpLines = index(DUMP, $0)
    if (dumpLines > 0)
        dump = 1
        
    if (dump > 0)
        next
    
    if (prevRegion != currRegion) { # 2
        prevRegion = currRegion
        } # 2
    #printf("#DEBUG100: NR: %d, currRegion: %d, %s\n", NR, currRegion, curLine)
    if ((line == -1) || (currRegion > 0)) { # 2
        #printf("#DEBUG110: currRegion: %d\n", currRegion)
        #printf("#DEBUG120: index(%s, %s)=%d\n", etfDefenseSymbols, curLine, index(etfDefenseSymbols, curLine)) 
        #printf("#DEBUG125: index(%s, %s)=%d\n", etfEnergySymbols, curLine, index(etfEnergySymbols, curLine))

        ###
        ### Capturing the individual indexes is state driven
        ### Line 0: ETF name
        ### Line 1: Current Net Asset Value
        ### Line 2: Gain/Loss (also grabs sign for +, - Pct Change)
        ### Line 3: Percent Change
        ###
    
        if (substr(curLine, 1, 5) != "Index") { # 3
                tallySummary(gainers * 1.0, losers * 1.0, pctChange, currRegion)
                gainers = 0
                losers = 0
                pctChange = 0.0
                line = -1
                } # 3
            }
        indexFound = index("Index" etfCustomLists, curLine)
        if (indexFound) { # 3
            line = 0
            } # 3
        else if (line == 0) { # 3
            printf("| %s ", curLine) # Name
            line ++
            } # 3
        else if (line == 1) { # 3
            if (substr(curLine, 1, 1) != "$")
                curLine = "$" curLine
            printf("| %s ", curLine) # Value
            line ++
            } # 3
        else if (line == 2) { # 3
            printf("| %s ", curLine) # Change
            direction = substr(curLine, 1, 1)
            if (direction == "-")
                losers ++
            else
                gainers ++
            arrow = (direction == "-" ? ":arrow_down:" : ":arrow_up:")
            line ++
            } # 3
        else if (line == 3) { # 3
            pctChange += substr(curLine, 1, length(curLine) - 1) * (arrow == ":arrow_down:" ? -1.0 : 1.0)
            printf("| %s %s |\n", arrow, curLine) # Percent Change
            line ++
            } # 3
        } # 2
    #} # 1
            
END {
    #printf("#DEBUG200: That's All Folks\n")
    tallySummary(gainers * 1.0, losers * 1.0, pctChange, 0)
    postTrailer()
    if (regionCount < 3)
        printf("*** WARNING! A region is missing! ***\n")
    }

###
### Prints Region's Summary
###
function tallySummary(gainers, losers, pct, newRegion) {
    regionCount ++
    total = gainers + losers
    marketStrength = ""
    #printf("\n\nDEBUG400: tableHeader: %s: tallySummary(newRegion: %d, pct: %0.2f, gainers: %d, losers: %d, total: %d)\n\n", tableHeader, newRegion, pct, gainers, losers, total)
    if (total > 0) {
        strength = (gainers / total) * 100.0
        marketStrength = assessRegion(strength)
        printf("| <strong>Avg Pct Chg: %0.2f%</strong> | <strong>gainers: %d (%0.2f%)</strong> | <strong>losers: %d (%0.2f%)</strong> | **%s** |\n", (pct / total), gainers, (gainers / total) * 100.0, losers, (losers / total) * 100.0, assessRegion(strength))

        if (tableHeader != "") {
            regionAssessment[tableHeader] = marketStrength
            }
        }

    if (newRegion > 0) {
        printf("| **%s** | | | |\n", curLine)
        tableHeader = curLine
        }

    #printf("#DEBUG420: strength: %f, marketStrength: %s\n", strength, marketStrength)

    gainers = 0
    losers = 0
    pctChange = 0.0
    }

function assessRegion(percent) {
    #printf("#DEBUG500: assessRegion: percent:%f\n", percent)
    regionStrength = ""
    # <= 29% (1)
    if (percent <= 29)
        regionStrength = "Strong Losses"
    # <= 41.5% (2)
    else if (percent <= 41.5)
        regionStrength = "Moderate Losses"
    # <= 58% (3)
    else if (percent <= 58)
        regionStrength = "Mixed"
    # <= 66% (4)
    else if (percent <= 70.5)
        regionStrength = "Moderate Gains"
    # <= 100% (5)
    else if (percent <= 100)
        regionStrength = "Strong Gains"
    else
        regionStrength = "Strong Gains"
    #printf("#DEBUG510: assessRegion: regionStrength: %s\n", regionStrength)
    return (regionStrength)
        }

function postHeader() {
    printf("---\n")
    printf("layout: post\n")
    printf("tags: [Stock Exchange,Location,New York Stock Exchange (NYSE),New York City USA,Nasdaq Stock Market	New York City USA,東京証券取引 (TSE),Tokyo Japan,上海证券交易所 (SSE),Shanghai China,香港聯合交易所 (HKEX),Hong Kong China,London Stock Exchange (LSE),London United Kingdom,Euronext	Amsterdam Brussels Dublin Lisbon Milan Oslo Paris,Toronto Stock Exchange (TSX),Toronto Canada,नेशनल स्टॉक एक्सचेंज (NSE),Mumbai India,बंबई स्टॉक एक्सचेंज (BSE),Mumbai India,深圳证券交易所 (SZSE),Shenzhen China,السوق المالية السعودية (تداول),Riyadh Saudi Arabia,Australian Securities Exchange (ASX),Sydney Australia,Deutsche Börse (Frankfurt Stock Exchange),Frankfurt Germany,SIX Swiss Exchange,Zurich Switzerland,한국거래소 (KRX),Seoul South Korea,臺灣證券交易所 (TWSE),Taipei Taiwan,Johannesburg Stock Exchange (JSE),Johannesburg South Africa,首页,Kuala Lumpur Malaysia,ตลาดหลักทรัพย์แห่งประเทศไทย (SET),Bangkok Thailand,新加坡交易所 (SGX),Singapore,Bolsa Mexicana de Valores (BMV),Mexico City Mexico,Московская Биржа (MOEX),Moscow Russia,A Bolsa do Brasil (B3),São Paulo Brazil,Constitution of the United States,Supreme Court of the United States (SCOTUS),US Courts,Federal Reserve Board,Jerome H. Powell,Department of Commerce (DOC),Treasury Department,Senate,House of Representatives,U.S. Department of the Treasury,Department of Commerce (DOC),President of the United States (POTUS),White House (WH),Trump crime businesses,Trump Organization,World Liberty Financial,$TRUMP,$MELANIA,The Mar-a-Lago Club,Trump International Golf Club,Trump National Doral Golf Club,Trump National Jupiter Golf Club,Trump National Golf Club Washington D.C.,Trump National Golf Club Bedminster,Trump National Golf Club Colts Neck,Trump National Golf Club Philadelphia,Trump National Golf Club Hudson Valley,Trump National Golf Club Westchester,Trump National Golf Club Los Angeles,Trump International Golf Club Dubai,Trump International Golf Links & Hotel Ireland Doonbeg,Trump MacLeod House & Lodge Scotland,Trump Turnberry,Trump crime family,Donald J Trump,Eric F. Trump / LinkedIn,Donald Trump Jr. / LinkedIn,Ivanka Trump,Jared Kushner,Adjusting Imports of Pharmaceuticals and Pharmaceutical Ingredients into the United States. Presidential Actions. Proclamations April 2 2026,Strengthening Actions Taken to Adjust Imports of Aluminum Steel and Copper Into the United States. Presidential Actions. Proclamations April 2 2026,Imposing a Temporary Import Surcharge to Address Fundamental International Payments Problems. Presidential Actions Proclamations February 20 2026,Continuing the Suspension of Duty-Free De Minimis Treatment for All Countries. Presidential Actions Executive Orders February 20 2026,Ending Certain Tariff Actions. Presidential Actions Executive Orders February 20 2026,Modifying Duties to Address Threats to the United States by the Government of the Russian Federation. Presidential Actions Executive Orders February 6 2026,Addressing Threats to the United States by the Government of Iran. Executive Orders. February 6 2026,Ensuring Affordable Beef for the American Consumer. Presidential Actions Proclamations February 6 2026,Addressing Threats to the United States by the Government of Cuba. Presidential Actions Executive Orders January 29 2026,ADJUSTING IMPORTS OF SEMICONDUCTORS SEMICONDUCTOR MANUFACTURING EQUIPMENT AND THEIR DERIVATIVE PRODUCTS INTO THE UNITED STATES. Presidential Actions. Proclamations. January 14 2026,Adjusting Imports of Processed Critical Minerals and Their Derivative Products into the United States. Presidential Actions. Proclamations. January 14 2026,Amendments to Adjusting Imports of Timber Lumber and their Derivative Products into the United States. Presidential Actions. Proclamations. December 31 2025,To Implement the United States-Israel Agreement on Trade in Agricultural Products and for Other Purposes. Presidential Actions. Proclamations. December 29 2025,Modifying the Scope of Tariffs on the Government of Brazil. Presidential Actions. Executive Orders. November 20 2025,Modifying the Scope of the Reciprocal Tariff with Respect to Certain Agricultural Products. Presidential Actions. Executive Orders. November 14 2025,Modifying Reciprocal Tariff Rates Consistent with the Economic and Trade Arrangement Between the United States and the People’s Republic of China. Presidential Actions. Executive Orders. November 4 2025,Modifying Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China. Presidential Actions. Executive Orders. November 4 2025,Regulatory Relief for Certain Stationary Sources to Promote American Mineral Security. Presidential Actions. Proclamations. October 24 2025,Adjusting Imports Of Medium- And Heavy-Duty Vehicles Medium- And Heavy-Duty Vehicle Parts And Buses Into The United States. Presidential Actions. Proclamations October 17 2025,Adjusting Imports of Timber Lumber and their Derivative Products into the United States. Presidential Actions. Proclamations September 29 2025,Modifying The Scope of Reciprocal Tariffs and Establishing Procedures for Implementing Trade and Security Agreements. Presidential Actions Executive Orders September 5 2025,Further Modifying Reciprocal Tariff Rates to Reflect Ongoing Discussions with The People’s Republic of China. Presidential Actions. Executive Orders August 11 2025,Fact Sheet–  President Donald J. Trump Continues the Suspension of the Heightened Tariffs on China. Fact Sheets. August 11 2025,Amendment to Duties to Address the Flow of Illicit Drugs Across Our Northern Border. Presidential Actions. Executive Orders. July 31 2025.,Further Modifying the Reciprocal Tariff Rates. Presidential Actions. Executive Orders. July 31 2025.,Fact Sheet–  President Donald J. Trump Amends Duties to Address the Flow of Illicit Drugs Across our Northern Border. Fact Sheets. July 31 2025.,Fact Sheet–  President Donald J. Trump Further Modifies the Reciprocal Tariff Rates. Fact Sheets. July 31 2025.,Addressing Threats to The United States by the Government of Brazil. Presidential Actions. Executive Orders. July 30 2025.,Fact Sheet–  President Donald J. Trump Addresses Threats to the United States from the Government of Brazil. Fact Sheets. July 30 2025.,Suspending Duty-Free De Minimis Treatment for All Countries. Presidential Actions. Executive Orders. July 30 2025.,Fact Sheet–  President Donald J. Trump is Protecting the United States’ National Security and Economy by Suspending the De Minimis Exemption for Commercial Shipments Globally. Fact Sheets. July 30 2025.,Adjusting Imports of Copper into the United States. Presidential Actions. Proclamations. July 30 2025.,Fact Sheet–  President Donald J. Trump Takes Action to Address the Threat to National Security from Imports of Copper. Fact Sheets July 30 2025.,Fact Sheet–  President Donald J. Trump Continues Enforcement of Reciprocal Tariffs and Announces New Tariff Rates. Fact Sheets. July 7 2025.,Extending the Modification of the Reciprocal Tariff Rates. Presidential Actions. Executive Orders. July 7 2025.,Extending the Modification of the Reciprocal Tariff Rates. Presidential Actions. Executive Orders. July 7 2025.,Implementing the General Terms of The United States of America-United Kingdom Economic Prosperity Deal. Presidential Actions. Executive Orders. June 16 2025.,Fact Sheet–  Implementing the General Terms of the U.S.-UK Economic Prosperity Deal. Fact Sheets. June 17 2025.,Fact Sheet–  President Donald J. Trump Increases Section 232 Tariffs on Steel and Aluminum. Fact Sheets. June 3 2025.,Adjusting Imports of Aluminum and Steel into the United States. Proclamations. June 3 2025.,Modifying Reciprocal Tariff Rates to Reflect Discussions with the People’s Republic of China. Presidential Actions. Executive Orders. May 12 2025.,Amendments to Adjusting Imports of Automobiles and Automobile Parts Into the United States. Presidential Actions. Proclamations. April 29 2025.,Fact Sheet–  President Donald J. Trump Incentivizes Domestic Automobile Production. Fact Sheets. April 29 2025.,Ensuring National Security and Economic Resilience Through Section 232 Actions on Processed Critical Minerals and Derivative Products. Presidential Actions. Executive Orders. April 15 2025.,Fact Sheet–  President Donald J. Trump Ensures National Security and Economic Resilience Through Section 232 Actions on Processed Critical Minerals and Derivative Products. Fact Sheets. April 15 2025.,Clarification of Exceptions Under Executive Order 14257 of April 2 2025. as Amended – The White House. Presidential Actions. Presidential Memoranda. April 11 2025.,Modifying Reciprocal Tariff Rates to Reflect Trading Partner Retaliation and Alignment. Presidential Actions. Executive Orders April 9 2025.,Amendment to Reciprocal Tariffs and Updated Duties as Applied to Low-Value Imports from the People’s Republic of China. Presidential Actions. Executive Orders. April 8 2025.,Report to the President on the America First Trade Policy Executive Summary. Fact Sheets. April 3 2025.,Regulating Imports with a Reciprocal Tariff to Rectify Trade Practices that Contribute to Large and Persistent Annual United States Goods Trade Deficits. Presidential Actions. Executive Orders. April 2 2025.,Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China as Applied to Low-Value Imports. Presidential Actions. Executive Orders. April 2 2025.,Fact Sheet–  President Donald J. Trump Declares National Emergency to Increase our Competitive Edge Protect our Sovereignty and Strengthen our National and Economic Security. Fact Sheets. April 2 2025.,Regulating Imports with a Reciprocal Tariff to Rectify Trade Practices that Contribute to Large and Persistent Annual United States Goods Trade Deficits. Presidential Actions. Executive Orders. April 2 2025.,Fact Sheet–  President Donald J. Trump Closes De Minimis Exemptions to Combat China’s Role in America’s Synthetic Opioid Crisis. Fact Sheets. April 2 2025.,Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China as Applied to Low-Value Imports. Presidential Actions. Executive Orders. April 2 2025.,Fact Sheet–  President Donald J. Trump Adjusts Imports of Automobiles and Automobile Parts into the United States. Fact Sheets. March 26 2025.,Fact Sheet–  President Donald J. Trump Imposes Tariffs on Countries Importing Venezuelan Oil. Fact Sheets. March 25 2025.,Imposing Tariffs on Countries Importing Venezuelan Oil. Presidential Actions. Executive Orders. March 24 2025.,Amendment to Duties to Address the Flow of Illicit Drugs Across Our Southern Border. Presidential Actions. March 6 2025.,Amendment to Duties to Address the Flow of Illicit Drugs Across Our Northern Border. Presidential Actions March 6 2025.,Fact Sheet–  President Donald J. Trump Proceeds with Tariffs on Imports from Canada and Mexico. Fact Sheets. March 3 2025.,Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China. Presidential Actions. March 3 2025.,Amendment to Duties to Address the Situation at our Southern Border. Presidential Actions March 2 2025.,Fact Sheet–  President Donald J. Trump Addresses the Threat to National Security from Imports of Timber Lumber and their Derivative Products. Fact Sheets. March 1 2025.,Addressing the Threat to National Security from Imports of Timber Lumber. Presidential Actions. March 1 2025.,Addressing the Threat to National Security from Imports of Copper. Presidential Actions February 25 2025.,Fact Sheet–  President Donald J. Trump Addresses the Threat to National Security from Imports of Copper. Fact Sheets. February 25 2025.,Defending American Companies and Innovators From Overseas Extortion and Unfair Fines and Penalties. Presidential Actions February 21 2025.,Fact Sheet–  President Donald J. Trump Issues Directive to Prevent the Unfair Exploitation of American Innovation. Fact Sheets. February 21 2025.,Remarks by President Trump at Republican Governors Association Meeting. Remarks February 20 2025.,Fact Sheet–  President Donald J. Trump Announces “Fair and Reciprocal Plan” on Trade. Fact Sheets. February 13 2025.,Fact Sheet–  President Donald J. Trump Restores Section 232 Tariffs. Fact Sheets. February 11 2025.,Adjusting Imports of Aluminum into The United States. Presidential Actions. February 11 2025.,Adjusting Imports of Steel into The United States. Presidential Actions. February 10 2025.,Fact Sheet–  President Donald J. Trump Restores American Competitiveness and Security in FCPA Enforcement. Fact Sheets. February 10 2025.,Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China. Presidential Actions February 5 2025.,Progress on the Situation at Our Northern Border. Presidential Actions. February 3 2025.,Progress on the Situation at Our Southern Border. Presidential Actions. February 3 2025.,Imposing Duties to Address the Synthetic Opioid Supply Chain in the People’s Republic of China. Presidential Actions. February 1 2025.,Imposing Duties to Address the Flow of Illicit Drugs Across Our Northern Border. Presidential Actions. February 1 2025.,Fact Sheet–  President Donald J. Trump Imposes Tariffs on Imports from Canada Mexico and China. Fact Sheets February 1 2025.,Imposing Duties to Address the Situation at Our Southern Border. Presidential Actions. February 1 2025.,America First Trade Policy. Presidential Actions January 20 2025.tariffs,politics,stupidity]\n")
        printf("categories: [finance,investing,stocks,indexes,⁰world stock market indexes]\n")

    if (curDate == "")
        curDate = ENVIRON["DATE"]
    if (curTime == "")
        curTime = ENVIRON["TIME"]

    printf("date: %s\n", (length(curDate curTime) > 0 ? curDate " " curTime : ""))
    printf("#excerpt: ''\n")
    printf("#image: 'BASEURL/assets/blog/img/.png'\n")
    printf("#description:\n")
    printf("#permalink:\n")
    printf("title: \"%s: World Stock Market Closing Indexes: Americas (no data). Europe, Middle East, & Africa (no data). Asia Pacific (no data). Defense ETFs (no data), Energy ETFs(no data).\"\n", curDate)
    printf("---\n")

    printf("\n\n## [Stock Market Indexes - Google Finance](https://www.google.com/finance/markets/indexes/)\n\n")
    printf("| Index | Closing Value | Gain/Loss | Percentage Change |\n")
    printf("|---|---:|---:|---:|\n")
    }

function printTitle() {
    # print title to move to Jekyll section

    #
    # Add the new Sector EFTs. Follow existing code
    # 
    title = sprintf("World Stock Market Closing Indexes: Americas (%s). Europe, Middle East, & Africa (%s). Asia Pacific (%s). Defense ETFs (%s), Energy ETFs(%s).", regionAssessment["Americas"], regionAssessment["Europe, Middle East, and Africa"], regionAssessment["Asia Pacific"], regionAssessment["Defense ETFs"], regionAssessment["Energy ETFs"])
    #printf("#DEBUG600: title: %s\n", title)

    printf("\ntitle: \"%s: %s\"\n---\n", curDate, title)

    # segment to print Liquid internal link for ../ClosingIndexes.md for yesterday, next day navigation links Filename Format(_posts/YYYY/MM/YYYY-MM-DD-YYYYMMDDClosingIndexes.md)
    path = "_posts/" substr(curDate, 1, 4) "/" substr(curDate, 6, 2) "/" curDate "-" substr(curDate, 1, 4) substr(curDate, 6, 2) substr(curDate,  9, 2) "ClosingIndexes.md"

    # Liquid link to copy to ../ClosingIndexes.md for yesterday's and tomorrow's link for yesterday's file
    printf("\n- [%s: %s]({%% link %s %%})\n\n", curDate, title, path)
    }

function postTrailer() {

    #
    # Add a new subroutine call that prints the table of subcategories of the new sector ETFs
    # 
    classifyDefenceETF()
    classifyEnergyETF()
    printWorldStockExchanges()
    printTrumpBusinesses()
    printFederalGovernment()
    printTrumpAutocracy()
    printTrumpCrimeBusinesses()
    printTrumpStupidity()

    # print at end of file. File will be positioned at EOF. This makes it easier to cut and paste in Jekyll and paste as title and navigation
    printTitle()
    }

# 
# Adding a new <sector> ETF:
# 1. Create a new subroutine in this style
# 2. Create a new file in the _includes folder containing a table that defines the specialty of the ETF
#
function classifyDefenceETF() {
    printf("\n{%% include classifyDefenseETF.html %%}\n")
    }
    
function classifyEnergyETF() {
    printf("\n{%% include classifyEnergyETF.html %%}\n")
    }

function printWorldStockExchanges() {
    printf("\n{%% include WorldStockExchanges.html %%}\n")
    }

function printTrumpBusinesses() {
    printf("\n### Where Can Trump Be Found?\n\n")
    printf("#### Where Trump Pretends To Work\n\n")
    printf("| Where Trump Pretends To Work |\n")
    printf("|---|\n")
    printf("| **[White House](https://www.whitehouse.gov)** |\n")
    printf("| 1600 Pennsylvania Ave., NW <br /> Washington, DC 20500 <br /> <a href=\"tel:+12024561111\">+1 (202) 456-1111</a> (comments) <br /> <a href=\"tel:+12024561414\">+1 (202) 456-1414</a> (switchboard) |\n")
    printf("\n#### If It’s The Weekend, Find Trump On One Of His Golf Courses\n\n")
    printf("\n{%% include TrumpGolf.html %%}\n")

    printf("\n{%% include TrumpLodging.html %%}\n\n")
    }

function printFederalGovernment() {
    printf("{%% include FederalGovernment.html %%}\n")
    }

function printTrumpAutocracy() {
    printf("{%% include TrumpAutocracy.html %%}\n")
    }

function printTrumpCrimeBusinesses () {
    printf("{%% include TrumpCrimeBusinesses.html %%}\n")
    }

function printTrumpStupidity() {
    printf("{%% include TrumpTariffs.html %%}\n")
    }

function cleanDumpReset() {
    #Turn dump OFF when the next ETF sector header appears
    if (dump == 1 && index(etfCustomLists, $0) > 0) {
        dump = 0
        }
    
    # Skip dumped lines
    if (dump == 1)
        next
    }