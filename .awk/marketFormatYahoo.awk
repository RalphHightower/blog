BEGIN {
    FS = ","
    newFileBegins = "Symbol,Current Price,Date,Time,Change,Open,High,Low,Volume,Trade Date,Purchase Price,Quantity,Commission,High Limit,Low Limit,Comment,Transaction Type"
    
    cur_date = ""
    cur_time = ""
    mktAmericas = ""
    mktEurope = ""
    mktAsia = ""
    # add new sector variable to hold the region's performance assessment
    mktDefense = "no data"
    mktEnergy = "no data"

    regionCount = 0

    #
    # Add the new <sector> name
    #
    region = "Americas|Europe, Middle East, and Africa|Asia, Pacific|Defense ETFs|Energy ETFs"
    cntRegions = split(region, regBreaks, "|")

    # Use associative arrays to hold the region's assessment
    for (ndx = 1; ndx <= cntRegions; ndx ++) {
        if (regBreaks[ndx] != "") {
            regionAssessment[regBreaks[ndx]] = "no data"
            }
        }
    #

    prevRegion = ""
    currRegion = ""
    resetStats()
    postJekyllHeader()
    buildRegionMapping()
    buildIndexMapping()

    # $FieldNames
    Symbol = 1
    CurrentPrice = 2
    Date = 3
    Time = 4
    Change = 5
    Open = 6
    High = 7
    Low = 8
    Volume = 9
    TradeDate = 10
    PurchasePrice = 11
    Quantity = 12
    Commission = 13
    HighLimit = 14
    LowLimit = 15
    Comment = 16
    TransactionType = 17

    }

{
    #
    #printf("#DEBUG0010: record: %s\n", $0)
    if (FNR == 1) {
        #printf("#DEBUG100: FILENAME: %s, map: %s\n", FILENAME, lookupRegion(FILENAME))
        if (NR > 1) {
            tallySummary(gainers * 1.0, losers * 1.0, pctChange, length(region) > 0)
            }
        region = lookupRegion(FILENAME)
        printf("| **%s** | | | |\n", region)
        #printf("#DEBUG110: FILENAME: %s. region: %s\n", FILENAME, region)
        resetStats()
        }
    else {
        pct = percentDiff($CurrentPrice, $Change)
        sign = ($Change * 1.0 < 0.0 ? -1.0 : 1.0)
        if (sign < 0.0)
            losers ++
        else
            gainers ++
        pctChange += pct
        arrow = (sign < 0.0 ? ":arrow_down:" : ":arrow_up:") " "
        printf("| %s | %s | %s | %s |\n", lookupSymbol($Symbol), formatCurrency($CurrentPrice), formatCurrency($Change), arrow formatPercent(pct))
        }
    }

END {
    #
    #printf("#DEBUG200: That's All Folks\n")
    tallySummary(gainers * 1.0, losers * 1.0, pctChange, 0)
    postTrailer()
    if (regionCount < 3)
        printf("*** WARNING! A region is missing! ***\n")
    for (ndx = 1; ndx <= cntRegions; ndx ++) {
        #printf("#DEBUG210: regionAssessment[%s] = \"%s\"\n", regBreaks[ndx], regionAssessment[regBreaks[ndx]])
        }
    }

function percentDiff(current, change) {
    original =  current - change
    diffPct = (current - (original)) / (original) * 100.0
    #printf("#DEBUG1210: original: %f, current: %f, change: %f, diffPct: %f\n", original, current, change, diffPct)
    pctChange += pctDiff
    return(diffPct)
    }
    
function formatPercent(pct) {
    #if (pct > -0.1 && pct < 0.1)
        return sprintf("%0.3f%%", pct)
    #else
        #return sprintf("%0.2f%%", pct)
    }
    
function formatCurrency(amount) {
    temp = sprintf("%0.3f", amount * 1.0)
    #printf("#DEBUG1310: amount: %f, temp: %f\n", amount, temp * 1.0)
    retVal = temp
    cnt = split(temp, money, ".")
    if (cnt == 2) {
        dollars = money[1]
        cents = money[2]
        #cents = substr(money[2] "0", 1, 3)
        len = length(dollars)
        commas = len / 3 - 1
        retVal = dollars "." cents
        #printf("#DEBUG1320: cnt: %d, dollars: %s, cents: %s, len: %d, commas: %d\n", cnt, dollars, cents, len, commas)
        if (commas > 0) {
            #0000000
            #000000
            #00000
            #0000
            retVal = ""
            comma = 3
            for (ndx = len; ndx > 0; ndx --) {
                retVal = substr(dollars, ndx, 1) retVal
                comma --
                #printf("#DEBUG1330: ndx: %d, comma: %s, retVal: %s\n", ndx, comma, retVal)
                if ((comma == 0) && (ndx > 1)){
                    retVal = "," retVal
                    comma = 3
                    }
                }
            retVal = retVal "." cents
            }
        } # concat
    #printf("#DEBUG1390: retVat: %s\n", retVal)
    return(retVal)
    }
    
function abs(value) {
    return(value < 0.0 ? -1 * value : value)
    }
    
function log10(value) {
    return(log(value) / log(10))
    }

function resetStats() {
    gainers = 0
    losers = 0
    pctChange = 0.0
    }

###
### Prints Region's Summary
###
function tallySummary(gainers, losers, pct, newRegion) {
    regionCount ++
    total = gainers + losers
    marketStrength = ""
    #printf("\n\n#DEBUG400: region: %s: tallySummary(newRegion: %d, pct: %f, gainers: %d, losers: %d, total: %d)\n\n", region, newRegion, pct, gainers, losers, total)
    if (total > 0) {
        strength = (gainers / total) * 100.0
        marketStrength = assessRegion(strength)
        tierLong = assessMovement(pct / total)
        tierShort = abbrMovement(tierLong)
        printf("| <strong>Avg Pct Chg: %0.3f% (%s)[^910]</strong> | <strong>gainers: %d (%0.2f%)</strong> | <strong>losers: %d (%0.2f%)</strong> | **%s** |\n", (pct / total), tierLong, gainers, (gainers / total) * 100.0, losers, (losers / total) * 100.0, assessRegion(strength))

        if (region != "") {
            regionAssessment[region] = marketStrength ", " tierShort
            }
        }

    #printf("#DEBUG420: strength: %f, marketStrength: %s, tierLong: %s, tierShort: %s.\n", strength, marketStrength, tierLong, tierShort)

    resetStats()
    }

function assessRegion(percent) {
    #printf("#DEBUG500: assessRegion: percent:%f\n", percent)
    regionStrength = ""
    regionStrength = (percent <= 29.0 ? "Strong Losses" :
        percent <= 41.5 ? "Moderate Losses" :
        percent <= 58 ? "Mixed" :
        percent <= 70.5 ? "Moderate Gains" : "Strong Gains")

    #printf("#DEBUG510: assessRegion: regionStrength: %s\n", regionStrength)

    return (regionStrength)
    }

function assessMovement(pctChg) {
    tmpPctChg = sprintf("%0.3f", pctChg) * 1.0
    #printf("#DEBUG701: tmpPctChg: %f, pctChg: %f\n", tmpPctChg, pctChg)
    movement = ""
    direction = tmpPctChg == 0.0 ? "" :
        tmpPctChg < 0.0 ? " Negative " : " Positive "
    tmpPctChg = abs(tmpPctChg)

    movement = (tmpPctChg == 0.0 ? "No" : 
        (tmpPctChg < 1.0 ? "Small" direction : 
        (tmpPctChg < 3.0 ? "Medium" direction : 
            "Large" direction))) " Movement"
    #printf("#DEBUG710 assessMovement(%f) = %s.\n", tmpPctChg, movement)
    return(movement)
    }

function abbrMovement(move) {
    abbr = move
    sub(" Movement", "", abbr)
    sub("Positive", "Pos", abbr)
    sub("Negative", "Neg", abbr)
    len = length(abbr)
    if (substr(abbr, len) == " ")
        abbr = substr(abbr, 1, len - 1)
    #printf("#DEBUG: abbrMovement(%s)=%s.\n", move, abbr)
    return(abbr)
    }

function postJekyllHeader() {
    printf("---\n")
    printf("layout: post\n")
    printTags()
    printCategories()

    if (curDate == "")
        curDate = ENVIRON["DATE"]
    if (curTime == "")
        curTime = ENVIRON["TIME"]

    printf("date: %s\n", (length(curDate curTime) > 0 ? curDate " " curTime : ""))
    printf("#excerpt: ''\n")
    printf("#image: 'BASEURL/assets/blog/img/.png'\n")
    printf("#description:\n")
    printf("#permalink:\n")
    printf("title: \"%s: World Stock Market Closing Indexes: Americas (no data). Europe, Middle East, & Africa (no data). Asia, Pacific (no data). Defense ETFs (no data), Energy ETFs (no data).\"\n", curDate)
    printf("---\n")

    printWatchlistSource()
    printfTableHeader()
    }
    
function printfTableHeader() {
    printf("| Index | Closing Value | Gain/Loss | Percentage Change |\n")
    printf("|---|---:|---:|---:|\n")
    }
    
function printWatchlistSource() {
    printf("\n\n## [Stock Portfolio Management & Tracker - Yahoo Finance](https://finance.yahoo.com/portfolios)[^101]\n\n")
    printf("[^101]: @RalphHightower: This link is my personalized watchlist for tracking stock indexes and sector ETFs.  [Yahoo Finance - Stock Market Live, Quotes, Business & Finance News](https://finance.yahoo.com/) is the generic link to build your own.\n\n")
    }

function printTitle() {
    # print title to move to Jekyll section

    #
    # Add the new Sector EFTs. Follow existing code
    #
    title = sprintf("World Stock Market Closing Indexes: Americas (%s). Europe, Middle East, & Africa (%s). Asia, Pacific (%s). Defense ETFs (%s). Energy ETFs (%s).", regionAssessment["Americas"], regionAssessment["Europe, Middle East, and Africa"], regionAssessment["Asia, Pacific"], regionAssessment["Defense ETFs"], regionAssessment["Energy ETFs"])
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
    explainMovement()
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

function explainMovement() {
    printf("\nAverage Percent Change Movement Basis — Magnitude of percentage change for regions and sectors. [^910]\n\n")
        printf("[^910]: Average Percent Change Movement Definition<br />• Small — less than 1.0%. Indicates a minor change in the region or sector.<br />• Medium — between 1.0% and 3.0%. Indicates a moderate change in the region or sector.<br />• Large — greater than 3.0%. Indicates a significant change in the region or sector.<br />• Direction (Positive or Negative) comes directly from the sign of the Avg Pct Chg value.\n")
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
    printf("\n#### If It’s The Weekend, Find Trump On One Of His Golf Courses\n")
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

function buildRegionMapping() {
    regionMap["portfolio.csv"] = "Americas"
    regionMap["portfolio (1).csv"] = "Europe, Middle East, and Africa"
    regionMap["portfolio (2).csv"] = "Asia, Pacific"
    regionMap["portfolio (3).csv"] = "Defense ETFs"
    regionMap["portfolio (4).csv"] = "Energy ETFs"
    }
    
function lookupRegion(file) {
    cntFileParts = split(file, fileParts, "/")
    region = regionMap[fileParts[2]]
    #printf("DEBUG910: fileParts[2]: %s, region: %s\n", fileParts[2], region)
    return(region != "" ? region : file)
    }

function lookupSymbol(symbol) {
    idx = IndexName[symbol]
    return(idx != "" ? idx : symbol)
    }
    
function printCategories() {
    printf("categories: [finance,investing,stocks,indexes,world stock market indexes,Americas,Europe Middle East Africa,Asia Pacific,Defense ETFs,Energy ETFs,Trump tariffs,Donald Trump,Trump global trade war,tariffs,global trade war,Trumpcession,Trumpflation]\n")
    }
    
function printTags() {
    printf("tags: [Stock Exchange,Location,New York Stock Exchange (NYSE),New York City USA,Nasdaq Stock Market	New York City USA,東京証券取引 (TSE),Tokyo Japan,上海证券交易所 (SSE),Shanghai China,香港聯合交易所 (HKEX),Hong Kong China,London Stock Exchange (LSE),London United Kingdom,Euronext	Amsterdam Brussels Dublin Lisbon Milan Oslo Paris,Toronto Stock Exchange (TSX),Toronto Canada,नेशनल स्टॉक एक्सचेंज (NSE),Mumbai India,बंबई स्टॉक एक्सचेंज (BSE),Mumbai India,深圳证券交易所 (SZSE),Shenzhen China,السوق المالية السعودية (تداول),Riyadh Saudi Arabia,Australian Securities Exchange (ASX),Sydney Australia,Deutsche Börse (Frankfurt Stock Exchange),Frankfurt Germany,SIX Swiss Exchange,Zurich Switzerland,한국거래소 (KRX),Seoul South Korea,臺灣證券交易所 (TWSE),Taipei Taiwan,Johannesburg Stock Exchange (JSE),Johannesburg South Africa,首页,Kuala Lumpur Malaysia,ตลาดหลักทรัพย์แห่งประเทศไทย (SET),Bangkok Thailand,新加坡交易所 (SGX),Singapore,Bolsa Mexicana de Valores (BMV),Mexico City Mexico,Московская Биржа (MOEX),Moscow Russia,A Bolsa do Brasil (B3),São Paulo Brazil,Constitution of the United States,Supreme Court of the United States (SCOTUS),US Courts,Federal Reserve Board,Kevin Warsh, Chairman,Department of Commerce (DOC),Treasury Department,Senate,House of Representatives,U.S. Department of the Treasury,Department of Commerce (DOC),President of the United States (POTUS),White House (WH),Trump crime businesses,Trump Organization,World Liberty Financial,$TRUMP,$MELANIA,The Mar-a-Lago Club,Trump International Golf Club,Trump National Doral Golf Club,Trump National Jupiter Golf Club,Trump National Golf Club Washington D.C.,Trump National Golf Club Bedminster,Trump National Golf Club Colts Neck,Trump National Golf Club Philadelphia,Trump National Golf Club Hudson Valley,Trump National Golf Club Westchester,Trump National Golf Club Los Angeles,Trump International Golf Club Dubai,Trump International Golf Links & Hotel Ireland Doonbeg,Trump MacLeod House & Lodge Scotland,Trump Turnberry,Trump crime family,Donald J Trump,Eric F. Trump / LinkedIn,Donald Trump Jr. / LinkedIn,Ivanka Trump,Jared Kushner,Adjusting Imports of Pharmaceuticals and Pharmaceutical Ingredients into the United States. Presidential Actions. Proclamations April 2 2026,Strengthening Actions Taken to Adjust Imports of Aluminum Steel and Copper Into the United States. Presidential Actions. Proclamations April 2 2026,Imposing a Temporary Import Surcharge to Address Fundamental International Payments Problems. Presidential Actions Proclamations February 20 2026,Continuing the Suspension of Duty-Free De Minimis Treatment for All Countries. Presidential Actions Executive Orders February 20 2026,Ending Certain Tariff Actions. Presidential Actions Executive Orders February 20 2026,Modifying Duties to Address Threats to the United States by the Government of the Russian Federation. Presidential Actions Executive Orders February 6 2026,Addressing Threats to the United States by the Government of Iran. Executive Orders. February 6 2026,Ensuring Affordable Beef for the American Consumer. Presidential Actions Proclamations February 6 2026,Addressing Threats to the United States by the Government of Cuba. Presidential Actions Executive Orders January 29 2026,ADJUSTING IMPORTS OF SEMICONDUCTORS SEMICONDUCTOR MANUFACTURING EQUIPMENT AND THEIR DERIVATIVE PRODUCTS INTO THE UNITED STATES. Presidential Actions. Proclamations. January 14 2026,Adjusting Imports of Processed Critical Minerals and Their Derivative Products into the United States. Presidential Actions. Proclamations. January 14 2026,Amendments to Adjusting Imports of Timber Lumber and their Derivative Products into the United States. Presidential Actions. Proclamations. December 31 2025,To Implement the United States-Israel Agreement on Trade in Agricultural Products and for Other Purposes. Presidential Actions. Proclamations. December 29 2025,Modifying the Scope of Tariffs on the Government of Brazil. Presidential Actions. Executive Orders. November 20 2025,Modifying the Scope of the Reciprocal Tariff with Respect to Certain Agricultural Products. Presidential Actions. Executive Orders. November 14 2025,Modifying Reciprocal Tariff Rates Consistent with the Economic and Trade Arrangement Between the United States and the People’s Republic of China. Presidential Actions. Executive Orders. November 4 2025,Modifying Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China. Presidential Actions. Executive Orders. November 4 2025,Regulatory Relief for Certain Stationary Sources to Promote American Mineral Security. Presidential Actions. Proclamations. October 24 2025,Adjusting Imports Of Medium- And Heavy-Duty Vehicles Medium- And Heavy-Duty Vehicle Parts And Buses Into The United States. Presidential Actions. Proclamations October 17 2025,Adjusting Imports of Timber Lumber and their Derivative Products into the United States. Presidential Actions. Proclamations September 29 2025,Modifying The Scope of Reciprocal Tariffs and Establishing Procedures for Implementing Trade and Security Agreements. Presidential Actions Executive Orders September 5 2025,Further Modifying Reciprocal Tariff Rates to Reflect Ongoing Discussions with The People’s Republic of China. Presidential Actions. Executive Orders August 11 2025,Fact Sheet–  President Donald J. Trump Continues the Suspension of the Heightened Tariffs on China. Fact Sheets. August 11 2025,Amendment to Duties to Address the Flow of Illicit Drugs Across Our Northern Border. Presidential Actions. Executive Orders. July 31 2025.,Further Modifying the Reciprocal Tariff Rates. Presidential Actions. Executive Orders. July 31 2025.,Fact Sheet–  President Donald J. Trump Amends Duties to Address the Flow of Illicit Drugs Across our Northern Border. Fact Sheets. July 31 2025.,Fact Sheet–  President Donald J. Trump Further Modifies the Reciprocal Tariff Rates. Fact Sheets. July 31 2025.,Addressing Threats to The United States by the Government of Brazil. Presidential Actions. Executive Orders. July 30 2025.,Fact Sheet–  President Donald J. Trump Addresses Threats to the United States from the Government of Brazil. Fact Sheets. July 30 2025.,Suspending Duty-Free De Minimis Treatment for All Countries. Presidential Actions. Executive Orders. July 30 2025.,Fact Sheet–  President Donald J. Trump is Protecting the United States’ National Security and Economy by Suspending the De Minimis Exemption for Commercial Shipments Globally. Fact Sheets. July 30 2025.,Adjusting Imports of Copper into the United States. Presidential Actions. Proclamations. July 30 2025.,Fact Sheet–  President Donald J. Trump Takes Action to Address the Threat to National Security from Imports of Copper. Fact Sheets July 30 2025.,Fact Sheet–  President Donald J. Trump Continues Enforcement of Reciprocal Tariffs and Announces New Tariff Rates. Fact Sheets. July 7 2025.,Extending the Modification of the Reciprocal Tariff Rates. Presidential Actions. Executive Orders. July 7 2025.,Extending the Modification of the Reciprocal Tariff Rates. Presidential Actions. Executive Orders. July 7 2025.,Implementing the General Terms of The United States of America-United Kingdom Economic Prosperity Deal. Presidential Actions. Executive Orders. June 16 2025.,Fact Sheet–  Implementing the General Terms of the U.S.-UK Economic Prosperity Deal. Fact Sheets. June 17 2025.,Fact Sheet–  President Donald J. Trump Increases Section 232 Tariffs on Steel and Aluminum. Fact Sheets. June 3 2025.,Adjusting Imports of Aluminum and Steel into the United States. Proclamations. June 3 2025.,Modifying Reciprocal Tariff Rates to Reflect Discussions with the People’s Republic of China. Presidential Actions. Executive Orders. May 12 2025.,Amendments to Adjusting Imports of Automobiles and Automobile Parts Into the United States. Presidential Actions. Proclamations. April 29 2025.,Fact Sheet–  President Donald J. Trump Incentivizes Domestic Automobile Production. Fact Sheets. April 29 2025.,Ensuring National Security and Economic Resilience Through Section 232 Actions on Processed Critical Minerals and Derivative Products. Presidential Actions. Executive Orders. April 15 2025.,Fact Sheet–  President Donald J. Trump Ensures National Security and Economic Resilience Through Section 232 Actions on Processed Critical Minerals and Derivative Products. Fact Sheets. April 15 2025.,Clarification of Exceptions Under Executive Order 14257 of April 2 2025. as Amended – The White House. Presidential Actions. Presidential Memoranda. April 11 2025.,Modifying Reciprocal Tariff Rates to Reflect Trading Partner Retaliation and Alignment. Presidential Actions. Executive Orders April 9 2025.,Amendment to Reciprocal Tariffs and Updated Duties as Applied to Low-Value Imports from the People’s Republic of China. Presidential Actions. Executive Orders. April 8 2025.,Report to the President on the America First Trade Policy Executive Summary. Fact Sheets. April 3 2025.,Regulating Imports with a Reciprocal Tariff to Rectify Trade Practices that Contribute to Large and Persistent Annual United States Goods Trade Deficits. Presidential Actions. Executive Orders. April 2 2025.,Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China as Applied to Low-Value Imports. Presidential Actions. Executive Orders. April 2 2025.,Fact Sheet–  President Donald J. Trump Declares National Emergency to Increase our Competitive Edge Protect our Sovereignty and Strengthen our National and Economic Security. Fact Sheets. April 2 2025.,Regulating Imports with a Reciprocal Tariff to Rectify Trade Practices that Contribute to Large and Persistent Annual United States Goods Trade Deficits. Presidential Actions. Executive Orders. April 2 2025.,Fact Sheet–  President Donald J. Trump Closes De Minimis Exemptions to Combat China’s Role in America’s Synthetic Opioid Crisis. Fact Sheets. April 2 2025.,Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China as Applied to Low-Value Imports. Presidential Actions. Executive Orders. April 2 2025.,Fact Sheet–  President Donald J. Trump Adjusts Imports of Automobiles and Automobile Parts into the United States. Fact Sheets. March 26 2025.,Fact Sheet–  President Donald J. Trump Imposes Tariffs on Countries Importing Venezuelan Oil. Fact Sheets. March 25 2025.,Imposing Tariffs on Countries Importing Venezuelan Oil. Presidential Actions. Executive Orders. March 24 2025.,Amendment to Duties to Address the Flow of Illicit Drugs Across Our Southern Border. Presidential Actions. March 6 2025.,Amendment to Duties to Address the Flow of Illicit Drugs Across Our Northern Border. Presidential Actions March 6 2025.,Fact Sheet–  President Donald J. Trump Proceeds with Tariffs on Imports from Canada and Mexico. Fact Sheets. March 3 2025.,Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China. Presidential Actions. March 3 2025.,Amendment to Duties to Address the Situation at our Southern Border. Presidential Actions March 2 2025.,Fact Sheet–  President Donald J. Trump Addresses the Threat to National Security from Imports of Timber Lumber and their Derivative Products. Fact Sheets. March 1 2025.,Addressing the Threat to National Security from Imports of Timber Lumber. Presidential Actions. March 1 2025.,Addressing the Threat to National Security from Imports of Copper. Presidential Actions February 25 2025.,Fact Sheet–  President Donald J. Trump Addresses the Threat to National Security from Imports of Copper. Fact Sheets. February 25 2025.,Defending American Companies and Innovators From Overseas Extortion and Unfair Fines and Penalties. Presidential Actions February 21 2025.,Fact Sheet–  President Donald J. Trump Issues Directive to Prevent the Unfair Exploitation of American Innovation. Fact Sheets. February 21 2025.,Remarks by President Trump at Republican Governors Association Meeting. Remarks February 20 2025.,Fact Sheet–  President Donald J. Trump Announces “Fair and Reciprocal Plan” on Trade. Fact Sheets. February 13 2025.,Fact Sheet–  President Donald J. Trump Restores Section 232 Tariffs. Fact Sheets. February 11 2025.,Adjusting Imports of Aluminum into The United States. Presidential Actions. February 11 2025.,Adjusting Imports of Steel into The United States. Presidential Actions. February 10 2025.,Fact Sheet–  President Donald J. Trump Restores American Competitiveness and Security in FCPA Enforcement. Fact Sheets. February 10 2025.,Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China. Presidential Actions February 5 2025.,Progress on the Situation at Our Northern Border. Presidential Actions. February 3 2025.,Progress on the Situation at Our Southern Border. Presidential Actions. February 3 2025.,Imposing Duties to Address the Synthetic Opioid Supply Chain in the People’s Republic of China. Presidential Actions. February 1 2025.,Imposing Duties to Address the Flow of Illicit Drugs Across Our Northern Border. Presidential Actions. February 1 2025.,Fact Sheet–  President Donald J. Trump Imposes Tariffs on Imports from Canada Mexico and China. Fact Sheets February 1 2025.,Imposing Duties to Address the Situation at Our Southern Border. Presidential Actions. February 1 2025.,America First Trade Policy. Presidential Actions January 20 2025.tariffs,politics,stupidity]\n")
    }

function buildIndexMapping() {
    buildIndexesEnergyETF()
    buildIndexesAsiaPacific()
    buildIndexesAmericas()
    buildIndexesDefenseETF()
    buildIndexesEMEA()
    }

function buildIndexes() {
    # -------------------------
    # 300
    # -------------------------
    IndexName["FTSE/ASEAN 40 Net Return Index"] = "Asia, Pacific"
    }

function buildIndexesAmericas() {
    # -------------------------
    # Americas
    # -------------------------
    IndexName["^B400"] = "Bloomberg 400"
    IndexName["^SKEW"] = "CBOE SKEW INDEX"
    IndexName["^VIX"] = "CBOE Volatility Index"
    IndexName["^DJGT"] = "Dow Jones Global Titans 50 Inde"
    IndexName["^DJI"] = "Dow Jones Industrial Average"
    IndexName["^DJT"] = "Dow Jones Transportation"
    IndexName["^TRAN"] = "Dow Jones Transportation Average"
    IndexName["^DWCF"] = "Dow Jones U.S. Completion"
    IndexName["^DJU"] = "Dow Jones U.S. Index"
    IndexName["^DJUS"] = "Dow Jones U.S. Index"
    IndexName["^DWRTF"] = "Dow Jones U.S. Select REIT Inde"
    IndexName["^BVSP"] = "IBOVESPA"
    IndexName["^MXX"] = "IPC MEXICO"
    IndexName["^BKX"] = "KBW Bank Index"
    IndexName["^MERV"] = "MERVAL"
    IndexName["^NDX"] = "NASDAQ 100"
    IndexName["^NDXTR"] = "NASDAQ 100 Total Return"
    IndexName["^BANK"] = "NASDAQ Bank Index"
    IndexName["^NBI"] = "NASDAQ Biotechnology Index"
    IndexName["^IXIC"] = "NASDAQ Composite"
    IndexName["^INDS"] = "NASDAQ Industrial Index"
    IndexName["^INSR"] = "NASDAQ Insurance Index"
    IndexName["^XAX"] = "NYSE AMEX Composite"
    IndexName["^BTK"] = "NYSE Biotechnology Index"
    IndexName["^NYA"] = "NYSE Composite Index"
    IndexName["^NYFANG"] = "NYSE FANG+ Index"
    IndexName["^DRG"] = "NYSE Pharmaceutical Index"
    IndexName["^VALUG"] = "NYSE Value Line Geometric"
    IndexName["^NDXTRND"] = "Pacer Nasdaq-100 Trendpilot Index"
    IndexName["^XAU"] = "Philadelphia Gold & Silver Index"
    IndexName["^OSX"] = "Philadelphia Oil Service Index"
    IndexName["^SOX"] = "Philadelphia Semiconductor Index"
    IndexName["^UTY"] = "PHLX Utility Sector"
    IndexName["^RUI"] = "Russell 1000"
    IndexName["^R2ICBENYT"] = "Russell 2000 Energy Supersector"
    IndexName["^RUT"] = "Russell 2000 Index"
    IndexName["^RUA"] = "Russell 3000"
    IndexName["^GSPC"] = "S&P 500"
    IndexName["^SPX"] = "S&P 500 INDEX"
    IndexName["^IPSA"] = "S&P IPSA (Chile)"
    IndexName["^MID"] = "S&P MidCap 400"
    IndexName["^SPTMI"] = "S&P Total Market Index (TMI)"
    IndexName["^GSPTSE"] = "S&P/TSX Composite Index"
    }

function buildIndexesEMEA() {
    # -------------------------
    # Europe, Middle East and Africa
    # -------------------------
    IndexName["^AEX"] = "AEX Amsterdam"
    IndexName["^AMX"] = "AMX Midcap"
    IndexName["^ATX"] = "ATX Austria"
    IndexName["^BFX"] = "BEL 20"
    IndexName["^FCHI"] = "CAC 40"
    IndexName["^BUK100P"] = "Cboe UK 100"
    IndexName["^GDAXI"] = "DAX"
    IndexName["^CASE30"] = "EGX 30 Price Return Index"
    IndexName["^STOXX50E"] = "Euro Stoxx 50"
    IndexName["^N100"] = "Euronext 100 Index"
    IndexName["^FTSE"] = "FTSE 100"
    IndexName["^FTMC"] = "FTSE 250"
    IndexName["^FTAS"] = "FTSE All-Share"
    IndexName["^FTAI"] = "FTSE All-Share Index"
    IndexName["FTSEMIB.MI"] = "FTSE MIB Index"
    IndexName["^MIB"] = "FTSE MIB Index (Italy)"
    IndexName["^HDAXI"] = "HDAX"
    IndexName["X2HZ.DE"] = "HDAX I"
    IndexName["^IBEX"] = "IBEX 35"
    IndexName["^NQFRSC"] = "NASDAQ France Small Cap Index"
    IndexName["^OMXC20"] = "OMX Copenhagen 20"
    IndexName["^OMXC25"] = "OMX Copenhagen 25"
    IndexName["^OMXH25"] = "OMX Helsinki 25"
    IndexName["^OMXR"] = "OMX Riga"
    IndexName["^OMXS30"] = "OMX Stockholm 30"
    IndexName[""] = "OMX Stockholm 30 Index"
    IndexName["^OMX"] = "OMX Stockholm 30 Index"
    IndexName["^OMXSBGI"] = "OMX Stockholm Benchmark GI"
    IndexName["^OMXSPI"] = "OMX Stockholm_PI"
    IndexName["^OMXT"] = "OMX Tallinn"
    IndexName["^OMXV"] = "OMX Vilnius"
    IndexName["^PSI20"] = "PSI 20"
    IndexName["^SPEURO"] = "S&P EURO"
    IndexName["^SPE350"] = "S&P Europe 350"
    IndexName["^SPEU"] = "S&P Europe 350"
    IndexName["^SPEUP"] = "S&P EUROPE 350"
    IndexName["^SBF120"] = "SBF 120"
    IndexName["^STOXX600"] = "STOXX Europe 600"
    IndexName["^STOXX"] = "STXE 600 I"
    IndexName["^SSMI"] = "Swiss Market Index"
    IndexName["^TA125"] = "TA-125 Index"
    IndexName["^TA35"] = "TA-35 Index"
    IndexName["211.TA"] = "TA35 EW"
    IndexName["^TASI"] = "Tadawul All Share Index"
    IndexName["^WIG"] = "WIG"
    IndexName["^WIG20"] = "WIG 20"
    IndexName["^WIG30"] = "WIG 30"
    IndexName["WIG20.WA"] = "WIG20"
    IndexName["WIG30.WA"] = "WIG30"
    }

function buildIndexesAsiaPacific() {
    # -------------------------
    # Asia, Pacific
    # -------------------------
    IndexName["^AXJO"] = "ASX 200"
    IndexName["^AXKO"] = "ASX All Ordinaries"
    IndexName["^BSESN"] = "BSE Sensex"
    IndexName["^FTSEASEAN"] = "FTSE ASEAN Index"
    IndexName["^KLSE"] = "FTSE Bursa Malaysia KLCI"
    IndexName["ASEAN40.FGI"] = "FTSE/ASEAN 40 Index"
    IndexName["ASEAN4WN.FGI"] = "FTSE/ASEAN 40 WM Net Tax Index"
    IndexName["^HSCE"] = "Hang Seng China Enterprises Index"
    IndexName["^HSI"] = "Hang Seng Index"
    IndexName["^JKSE"] = "Jakarta Composite Index"
    IndexName["^JKLQ45"] = "Jakarta LQ45 Index"
    IndexName["^KS11"] = "KOSPI Composite"
    IndexName["^HXC"] = "NASDAQ Golden Dragon China Inde"
    IndexName["^NQJP20N"] = "NASDAQ Japan Health Care NTR In"
    IndexName["^NSEI"] = "Nifty 50"
    IndexName["^NSEBANK"] = "NIFTY BANK"
    IndexName["^N225"] = "Nikkei 225"
    IndexName["^NZ50"] = "NZX 50"
    IndexName["^BSESN"] = "S&P BSE SENSEX"
    IndexName["^SSE180"] = "SSE 180 Index"
    IndexName["^SSE50"] = "SSE 50 Index"
    IndexName["000001.SS"] = "SSE Composite Index"
    IndexName["000129.SS"] = "SSE180 Volatility Weighted Inde"
    IndexName["000052.SS"] = "SSE50 Fundamental Weighted Index"
    IndexName["^STI"] = "STI (Singapore Times) Index"
    IndexName["^TWII"] = "Taiwan Weighted Index"
    }

function buildIndexesDefenseETF() {
    # -------------------------
    # Defense ETF
    # -------------------------
    IndexName["ARKQ"] = "ARK Autonomous Technology & Robotics ETF"
    IndexName["ARKX"] = "ARK Space & Defense Innovation ETF"
    IndexName["JEDI"] = "Defiance Drone and Modern Warfare ETF"
    IndexName["DFEN"] = "Direxion Daily Aerospace & Defense Bull 3X Shares"
    IndexName["FSPC"] = "First Trust Bloomberg Space Economy ETF"
    IndexName["MISL"] = "First Trust Indxx Aerospace & Defense ETF"
    IndexName["GCAD"] = "Gabelli Commercial Aerospace & Defense ETF"
    IndexName["SHLD"] = "Global X Defense Tech ETF"
    IndexName["ORBX"] = "Global X Space Tech ETF"
    IndexName["PPA"] = "Invesco Aerospace & Defense ETF"
    IndexName["IDEF"] = "iShares Defense Industrials Act"
    IndexName["ITA"] = "iShares U.S. Aerospace & Defense ETF"
    IndexName["KDEF"] = "PLUS Korea Defense Industry Index ETF"
    IndexName["UFO"] = "Procure Space ETF"
    IndexName["DRNZ"] = "REX Drone ETF"
    IndexName["^ROBOTR"] = "ROBO Global Robotics and Automa"
    IndexName["MARS"] = "Roundhill Space & Technology ETF"
    IndexName["^KDRONE"] = "S&P Kensho Drones Index (USD) T"
    IndexName["EUAD"] = "Select STOXX Europe Aerospace & Defense ETF"
    IndexName["^DXS"] = "SPADE Defense Index"
    IndexName["XAR"] = "State Street SPDR S&P Aerospace & Defense"
    IndexName["ROKT"] = "State Street SPDR S&P Kensho Final Frontiers"
    IndexName["FITE"] = "State Street SPDR S&P Kensho Future Security ETF"
    IndexName["NASA"] = "Tema Space Innovators ETF"
    IndexName["NATO"] = "Themes Transatlantic Defense ETF"
    IndexName["DUTY"] = "U.S. Defense ETF"
    IndexName["WAR"] = "U.S. Global Technology and Aerospace & Defense ETF"
    IndexName["WARP"] = "VanEck Space ETF"
    IndexName["AMMO"] = "VistaShares Defense Supercycle ETF"
    IndexName["GALX"] = "VistaShares Space Supercycle ETF"
    IndexName["WDAF"] = "WisdomTree Asia Defense Fund"
    IndexName["WDGF"] = "WisdomTree Global Defense Fund"
    IndexName["WDEF"] = "WisdomTree Trust"
    }

function buildIndexesEnergyETF() {
    # -------------------------
    # Energy ETF
    # -------------------------
    IndexName["ENFR"] = "Alerian Energy Infrastructure ETF"
    IndexName["^AMNA"] = "Alerian Midstream Energy Total"
    IndexName["AMLP"] = "Alerian MLP ETF"
    IndexName["CCNR"] = "ALPS/CoreCommodity Natural Resources ETF"
    IndexName["BWET"] = "Breakwave Tanker Shipping ETF"
    IndexName["CSNR"] = "Cohen & Steers Natural Resources Active ETF"
    IndexName["USOY"] = "Defiance Oil Enhanced Options Income ETF"
    IndexName["ERY"] = "Direxion Daily Energy Bear 2X Shares"
    IndexName["ERX"] = "Direxion Daily Energy Bull 2X Shares"
    IndexName["TEXU"] = "Direxion Daily Energy Top 5 Bull 2X ETF"
    IndexName["DRIP"] = "Direxion Daily S&P Oil & Gas Exp. & Prod. Bear 2X Shares"
    IndexName["GUSH"] = "Direxion Daily S&P Oil & Gas Exp. & Prod. Bull 2X Shares"
    IndexName["UTSL"] = "Direxion Daily Utilities Bull 3X Shares"
    IndexName["FENY"] = "Fidelity MSCI Energy Index ETF"
    IndexName["FUTY"] = "Fidelity MSCI Utilities Index ETF"
    IndexName["RBLD"] = "First Trust Alerian U.S. NextGen Infrastructure ETF"
    IndexName["FTRI"] = "First Trust Indxx Global Natural Resources Income ETF"
    IndexName["FTXN"] = "First Trust Nasdaq Oil & Gas ETF"
    IndexName["FCG"] = "First Trust Natural Gas ETF"
    IndexName["EMLP"] = "First Trust North American Energy Infrastructure Fund"
    IndexName["FXU"] = "First Trust Utilities AlphaDEX Fund"
    IndexName["GUNR"] = "FlexShares Morningstar Global Upstream Natural Resources Index Fund"
    IndexName["NFRA"] = "FlexShares STOXX Global Broad Infrastructure Index Fund"
    IndexName["EIPI"] = "FT Energy Income Partners Enhanced Income ETF"
    IndexName["MLPX"] = "Global X MLP & Energy Infrastructure ETF"
    IndexName["URA"] = "Global X Uranium ETF"
    IndexName["AMZA"] = "InfraCap MLP ETF"
    IndexName["DBO"] = "Invesco DB Oil Fund"
    IndexName["PUI"] = "Invesco Dorsey Wright Utilities Momentum ETF"
    IndexName["PXI"] = "Invesco DWA Energy Momentum ETF"
    IndexName["PXE"] = "Invesco Dynamic Energy Exploration & Production ETF"
    IndexName["PXJ"] = "Invesco Oil & Gas Services ETF"
    IndexName["RSPG"] = "Invesco S&P 500 Equal Weight Energy ETF"
    IndexName["RSPU"] = "Invesco S&P 500 Equal Weight Utilities ETF"
    IndexName["SCO"] = "Invesco S&P 500 Equal Weight Utilities ETF"
    IndexName["PSCE"] = "Invesco S&P SmallCap Energy ETF"
    IndexName["IXC"] = "iShares Global Energy ETF"
    IndexName["IGF"] = "iShares Global Infrastructure ETF"
    IndexName["JXI"] = "iShares Global Utilities ETF"
    IndexName["IYE"] = "iShares U.S. Energy ETF"
    IndexName["IFRA"] = "iShares U.S. Infrastructure ETF"
    IndexName["IEO"] = "iShares U.S. Oil & Gas Exploration & Production ETF"
    IndexName["IEZ"] = "iShares U.S. Oil Equipment & Service"
    IndexName["IDU"] = "iShares U.S. Utilities ETF"
    IndexName["NRGD"] = "MicroSectors U.S. Big Oil -3x Inverse Leveraged ETNs"
    IndexName["NRGU"] = "Microsectors U.S. Big Oil 3x Leveraged ETNs"
    IndexName["OIH"] = "Microsectors U.S. Big Oil 3x Leveraged ETNs"
    IndexName["OILD"] = "MicroSectorsTM Oil & Gas Exploration & Production -3X Inverse Leveraged ETNs"
    IndexName["OILU"] = "MicroSectorsTM Oil & Gas Exploration & Production 3X Leveraged ETNs"
    IndexName["USAI"] = "Pacer American Energy Infrastructure ETF"
    IndexName["TOLZ"] = "ProShares DJ Brookfield Global Infrastructure ETF"
    IndexName["OILK"] = "ProShares K-1 Free Crude Oil ETF"
    IndexName["UCO"] = "ProShares Ultra Bloomberg Crude Oil"
    IndexName["BOIL"] = "ProShares Ultra Bloomberg Natural Gas"
    IndexName["DIG"] = "ProShares Ultra Energy"
    IndexName["UPW"] = "ProShares Ultra Utilities"
    IndexName["KOLD"] = "ProShares UltraShort Bloomberg Natural Gas"
    IndexName["DUG"] = "ProShares UltraShort Energy ETF"
    IndexName["NUKZ"] = "Range Nuclear Renaissance ETF"
    IndexName["^SPGCL2LT"] = "S&P GSCI Crude Oil 2X Leveraged"
    IndexName["URNJ"] = "Sprott Junior Uranium Miners ETF"
    IndexName["URNM"] = "Sprott Uranium Miners ETF"
    IndexName["XLE"] = "State Street Energy Select Sector SPDR ETF"
    IndexName["GII"] = "State Street SPDR S&P Global Infrastructure ETF"
    IndexName["GNR"] = "State Street SPDR S&P Global Natural Resources ETF"
    IndexName["NANR"] = "State Street SPDR S&P North American Natural Resources ETF"
    IndexName["XES"] = "State Street SPDR S&P Oil & Gas Equipment & Services ETF"
    IndexName["XOP"] = "State Street SPDR S&P Oil & Gas Exploration & Production ETF"
    IndexName["XLU"] = "State Street Utilities Select Sector SPDR ETF"
    IndexName["OILT"] = "Texas Capital Texas Oil Index ETF"
    IndexName["TPYP"] = "Tortoise North American Pipeline Fund"
    IndexName["USL"] = "United States 12 Month Oil Fund, LP"
    IndexName["BNO"] = "United States Brent Oil Fund, LP"
    IndexName["UGA"] = "United States Gasoline Fund, LP"
    IndexName["UNG"] = "United States Natural Gas Fund, LP"
    IndexName["USO"] = "United States Oil Fund, LP"
    IndexName["UMI"] = "USCF Midstream Energy Income Fund"
    IndexName["EINC"] = "VanEck Energy Income ETF"
    IndexName["CRAK"] = "VanEck Oil Refiners ETF"
    IndexName["NLR"] = "VanEck Uranium and Nuclear ETF"
    IndexName["VDE"] = "Vanguard Energy Index Fund ETF Shares"
    IndexName["VPU"] = "Vanguard Utilities Index Fund ETF Shares"
    IndexName["UTES"] = "Virtus Reaves Utilities ETF"
    }
