# Used to format Market Indexes from Google Finance
# I haven't been able to pass date and time as parameters, but passing DATE. TIME as environment variables works

BEGIN {

    cur_date = ""
    cur_time = ""
    mktAmericas = ""
    mktEurope = ""
    mktAsia = ""

    rgxDate = "[2-9][0-9][0-9)[0-9]-[01][0-9]-[0-3][0-9]"
    rgxTime = "([01][0-9]:[0-5][0-9] [A|P]M)|([012][0-9]:[0-5][0-9])"

    for (ndx = 1; ndx < ARGC; ndx++) {
        if (match($ndx, rgxDate) > 0) {
            cur_date = ARGV[ndx]
            ARGV[ndx] = null
            }
        else if (match($ndx, rgxTime) > 0) {
            curTime = ARGV[ndx]
            ARGV[ndx] = null
            }
        }

    region = "|Americas|Europe, Middle East, and Africa|Asia Pacific|"
    ndxAMERICA = 2
    ndxEUROPE = 11
    ndxASIA = 42
    gainers = 0
    losers = 0
    pctChange = 0.0
    line = -1
    postHeader()
    }
{
    regionHeading = index(region, $0)
    #printf("#DEBUG: NR: %d, regionHeading, %s\n", NR, regionHeading, $0)
    if ((line == -1) || (regionHeading > 0)) {
        #printf("#DEBUG: regionHeading: %d\n", regionHeading)
        if (substr($0, 1, 5) != "Index") {
            tallySummary(gainers * 1.0, losers * 1.0, pctChange, regionHeading)
            gainers = 0
            losers = 0
            pctChange = 0.0
            line = -1
            }
        }
    if (substr($0, 1, 5) == "Index") {
        line = 0
        }
    else if (line == 0) {
        printf("| %s ", $0) # Name
        line ++
        }
    else if (line == 1) {
        printf("| %s ", $0) # Value
        line ++
        }
    else if (line == 2) {
        printf("| %s ", $0) # Change
        direction = substr($0, 1, 1)
        if (direction == "-")
            losers ++
        else
            gainers ++
        arrow = (direction == "-" ? ":arrow_down:" : ":arrow_up:")
        line ++
        }
    else if (line == 3) {
        pctChange += substr($0, 1, length($0) - 1) * (arrow == ":arrow_down:" ? -1.0 : 1.0)
        printf("| %s %s |\n", arrow, $0) # Percent Change
        line ++
        }
    }
END {
#printf("DEBUG: That's All Folks\n")
    tallySummary(gainers * 1.0, losers * 1.0, pctChange, 0)
    postTrailer()
    }

function tallySummary(gainers, losers, pct, newRegion) {
    total = gainers + losers
    marketStrength = ""
    #printf("\n\nDEBUG: tallySummary(newRegion: %d, pct: %0.2f, gainers: %d, losers: %d, total: %d)\n\n", newRegion, pct, gainers, losers, total)
    if (total > 0) {
        strength = (gainers / total) * 100.0
        marketStrength = assessRegion(strength)
        printf("| <strong>Avg Pct Chg: %0.2f%</strong> | <strong>gainers: %d (%0.2f%)</strong> | <strong>losers: %d (%0.2f%)</strong> | **%s** |\n", (pct / total), gainers, (gainers / total) * 100.0, losers, (losers / total) * 100.0, assessRegion(strength))

        if (newRegion == 11)
            mktAmericas = marketStrength
        else if (newRegion == 43)
            mktEurope = marketStrength
        else
            mktAsia = marketStrength
        #printf("DEBUG: mktAmericas: %s, mktEurope: %s, mktAsia: %s\n", mktAmericas, mktEurope, mktAsia)
        }
    if (newRegion > 0)
        printf("| **%s** | | | |\n", $0)

    #printf("DEBUG: strength: %f, marketStrength: %s\n", strength, marketStrength)
    
    gainers = 0
    losers = 0
    pctChange = 0.0
    }

function assessRegion(percent) {
    #printf("DEBUG assessRegion: percent:%f\n", percent)
    regionStrength = ""
    # <= 25% (1)
    if (percent <= 25)
        regionStrength = "Strong Losses"
    # <= 29% (2)
    else if (percent <= 29)
        regionStrength = "Strong Losses"
    # <= 33% (3)
    else if (percent <= 33)
        regionStrength = "Moderate Losses"
    # <= 41.5% (4)
    else if (percent <= 41.5)
        regionStrength = "Moderate Losses"
    # <= 50% (5)
    else if (percent <= 50)
        regionStrength = "Mixed"
    # <= 58% (6)
    else if (percent <= 58)
        regionStrength = "Mixed"
    # <= 66% (7)
    else if (percent <= 66)
        regionStrength = "Moderate Gains"
    # <= 70.5% (8)
    else if (percent <= 70.5)
        regionStrength = "Moderate Gains"
    # <= 75% (9)
    else if (percent <= 75)
        regionStrength = "Strong Gains"
    # <= 87.5% (10)
    else if (percent <= 87.5)
        regionStrength = "Strong Gains"
    # <= 100% (11)
    else if (percent <= 100)
        regionStrength = "Strong Gains"
    else
        regionStrength = "Strong Gains"
    #printf("DEBUG assessRegion: regionStrength: %s\n", regionStrength)
    return (regionStrength)
        }

function postHeader() {
    printf("---\n")
    printf("layout: post\n")
    printf("tags: [Stock Exchange, Location, New York Stock Exchange (NYSE), New York City USA, Nasdaq Stock Market	New York City USA, 東京証券取引 (TSE), Tokyo Japan, 上海证券交易所 (SSE), Shanghai China, 香港聯合交易所 (HKEX), Hong Kong China, London Stock Exchange (LSE), London United Kingdom, Euronext	Amsterdam Brussels Dublin Lisbon Milan Oslo Paris, Toronto Stock Exchange (TSX), Toronto Canada, नेशनल स्टॉक एक्सचेंज (NSE), Mumbai India, बंबई स्टॉक एक्सचेंज (BSE), Mumbai India, 深圳证券交易所 (SZSE), Shenzhen China, السوق المالية السعودية (تداول), Riyadh Saudi Arabia, Australian Securities Exchange (ASX), Sydney Australia, Deutsche Börse (Frankfurt Stock Exchange), Frankfurt Germany, SIX Swiss Exchange, Zurich Switzerland, 한국거래소 (KRX), Seoul South Korea, 臺灣證券交易所 (TWSE), Taipei Taiwan, Johannesburg Stock Exchange (JSE), Johannesburg South Africa, 首页, Kuala Lumpur Malaysia, ตลาดหลักทรัพย์แห่งประเทศไทย (SET), Bangkok Thailand, 新加坡交易所 (SGX), Singapore, Bolsa Mexicana de Valores (BMV), Mexico City Mexico, Московская Биржа (MOEX), Moscow Russia, A Bolsa do Brasil (B3), São Paulo Brazil, Constitution of the United States, Supreme Court of the United States (SCOTUS), US Courts, Federal Reserve Board, Jerome H. Powell, Department of Commerce (DOC), Treasury Department, Senate, House of Representatives, U.S. Department of the Treasury, Department of Commerce (DOC), President of the United States (POTUS), White House (WH), Trump crime businesses, Trump Organization, World Liberty Financial, $TRUMP, $MELANIA, The Mar-a-Lago Club, Trump International Golf Club, Trump National Doral Golf Club, Trump National Jupiter Golf Club, Trump National Golf Club Washington D.C., Trump National Golf Club Bedminster, Trump National Golf Club Colts Neck, Trump National Golf Club Philadelphia, Trump National Golf Club Hudson Valley, Trump National Golf Club Westchester, Trump National Golf Club Los Angeles, Trump International Golf Club Dubai, Trump International Golf Links & Hotel Ireland Doonbeg, Trump MacLeod House & Lodge Scotland, Trump Turnberry, Trump crime family, Donald J Trump, Eric F. Trump / LinkedIn, Donald Trump Jr. / LinkedIn, Ivanka Trump, Jared Kushner, Howard Lutnick, Howard W. Lutnick, Scott Bessent, Fact Sheet – President Donald J. Trump Continues Enforcement of Reciprocal Tariffs and Announces New Tariff Rates. Fact Sheets July 7 2025, Extending the Modification of the Reciprocal Tariff Rates. Presidential Actions Executive Orders July 7 2025, Extending the Modification of the Reciprocal Tariff Rates. Presidential Actions Executive Orders July 7 2025, Implementing the General Terms of The United States of America-United Kingdom Economic Prosperity Deal. Presidential Actions Executive Orders June 16 2025, Fact Sheet – Implementing the General Terms of the U.S.-UK Economic Prosperity Deal. Fact Sheets. June 17 2025, Fact Sheet – President Donald J. Trump Increases Section 232 Tariffs on Steel and Aluminum. Fact Sheets. June 3 2025, Adjusting Imports of Aluminum and Steel into the United States. Proclamations. June 3 2025, Modifying Reciprocal Tariff Rates to Reflect Discussions with the People’s Republic of China. Presidential Actions Executive Orders May 12 2025, Addressing Certain Tariffs on Imported Articles. Presidential Actions Executive Orders. April 29 2025, Amendments to Adjusting Imports of Automobiles and Automobile Parts Into the United States. Presidential Actions Proclamations. April 29 2025, Fact Sheet – President Donald J. Trump Incentivizes Domestic Automobile Production. Fact Sheets. April 29 2025, Ensuring National Security and Economic Resilience Through Section 232 Actions on Processed Critical Minerals and Derivative Products. Presidential Actions Executive Orders. April 15 2025, Fact Sheet – President Donald J. Trump Ensures National Security and Economic Resilience Through Section 232 Actions on Processed Critical Minerals and Derivative Products. Fact Sheets. April 15 2025, Clarification of Exceptions Under Executive Order 14257 of April 2 2025 as Amended – The White House. Presidential Actions Presidential Memoranda April 11 2025, Modifying Reciprocal Tariff Rates to Reflect Trading Partner Retaliation and Alignment. Presidential Actions Executive Orders April 9 2025, Amendment to Reciprocal Tariffs and Updated Duties as Applied to Low-Value Imports from the People’s Republic of China. Presidential Actions Executive Orders April 8 2025, Report to the President on the America First Trade Policy Executive Summary. Fact Sheets April 3 2025, Regulating Imports with a Reciprocal Tariff to Rectify Trade Practices that Contribute to Large and Persistent Annual United States Goods Trade Deficits. Presidential Actions Executive Orders April 2 2025, Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China as Applied to Low-Value Imports. Presidential Actions Executive Orders April 2 2025, Fact Sheet – President Donald J. Trump Declares National Emergency to Increase our Competitive Edge Protect our Sovereignty and Strengthen our National and Economic Security. Fact Sheets April 2 2025, Regulating Imports with a Reciprocal Tariff to Rectify Trade Practices that Contribute to Large and Persistent Annual United States Goods Trade Deficits. Presidential Actions Executive Orders April 2 2025, Fact Sheet – President Donald J. Trump Closes De Minimis Exemptions to Combat China’s Role in America’s Synthetic Opioid Crisis. Fact Sheets April 2 2025, Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China as Applied to Low-Value Imports. Presidential Actions Executive Orders April 2 2025, Fact Sheet – President Donald J. Trump Adjusts Imports of Automobiles and Automobile Parts into the United States. Fact Sheets March 26 2025, The Staggering Cost of the Illicit Opioid Epidemic in the United States. Articles March 26 2025, Fact Sheet – President Donald J. Trump Imposes Tariffs on Countries Importing Venezuelan Oil. Fact Sheets March 25 2025, Imposing Tariffs on Countries Importing Venezuelan Oil. Presidential Actions Executive Orders March 24 2025, More Investment More Jobs and More Money in Americans’ Pockets. Articles March 24 2025, President Trump Positions U.S. as Global Superpower in Manufacturing. Articles March 20 2025, President Trump is Remaking America into a Manufacturing Superpower. Articles March 12 2025, Amendment to Duties to Address the Flow of Illicit Drugs Across Our Southern Border. Presidential Actions March 6 2025, Amendment to Duties to Address the Flow of Illicit Drugs Across Our Northern Border. Presidential Actions March 6 2025, President Trump is Putting American Workers First — And Bringing Back American Manufacturing. Articles March 4 2025, President Trump is Securing Our Homeland. Articles March 4 2025, Fact Sheet – President Donald J. Trump Proceeds with Tariffs on Imports from Canada and Mexico. Fact Sheets March 3 2025, Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China. Presidential Actions March 3 2025, Amendment to Duties to Address the Situation at our Southern Border. Presidential Actions March 2 2025, Fact Sheet – President Donald J. Trump Addresses the Threat to National Security from Imports of Timber Lumber and their Derivative Products. Fact Sheets March 1 2025, Addressing the Threat to National Security from Imports of Timber Lumber. Presidential Actions March 1 2025, Addressing the Threat to National Security from Imports of Copper. Presidential Actions February 25 2025, Fact Sheet – President Donald J. Trump Addresses the Threat to National Security from Imports of Copper. Fact Sheets February 25 2025, Defending American Companies and Innovators From Overseas Extortion and Unfair Fines and Penalties.. Presidential Actions February 21 2025, Fact Sheet – President Donald J. Trump Issues Directive to Prevent the Unfair Exploitation of American Innovation. Fact Sheets February 21 2025, Remarks by President Trump at Republican Governors Association Meeting. Remarks February 20 2025, President Trump Demands Fair Reciprocal Trade. Articles February 13 2025, Fact Sheet – President Donald J. Trump Announces “Fair and Reciprocal Plan” on Trade. Fact Sheets February 13 2025, Reciprocal Trade and Tariffs. Articles February 13 2025, Fact Sheet – President Donald J. Trump Restores Section 232 Tariffs. Fact Sheets February 11 2025, Adjusting Imports of Aluminum into The United States. Presidential Actions February 11 2025, Adjusting Imports of Steel into The United States. Presidential Actions February 10 2025, Fact Sheet – President Donald J. Trump Restores American Competitiveness and Security in FCPA Enforcement. Fact Sheets February 10 2025, Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China. Presidential Actions February 5 2025, Progress on the Situation at Our Northern Border. Presidential Actions February 3 2025, Progress on the Situation at Our Southern Border. Presidential Actions February 3 2025, Imposing Duties to Address the Synthetic Opioid Supply Chain in the People’s Republic of China. Presidential Actions February 1 2025, Imposing Duties to Address the Flow of Illicit Drugs Across Our Northern Border. Presidential Actions February 1 2025, Fact Sheet – President Donald J. Trump Imposes Tariffs on Imports from Canada Mexico and China. Fact Sheets February 1 2025, Imposing Duties to Address the Situation at Our Southern Border. Presidential Actions February 1 2025, America First Trade Policy. Presidential Actions January 20 2025, tariffs, politics, stupidity]\n")
    printf("categories: [world stock market indexes]\n")

    if (curDate == "")
        curDate = ENVIRON["DATE"]
    if (curTime == "")
        curTime = ENVIRON["TIME"]

    printf("date: %s\n", (length(curDate curTime) > 0 ? curDate " " curTime : ""))
    printf("#excerpt: ''\n")
    printf("#image: 'BASEURL/assets/blog/img/.png'\n")
    printf("#description:\n")
    printf("#permalink:\n")
    printf("title: \"%s: World Stock Market Closing Indexes: Americas (). Europe, Middle East, & Africa (). Asia Pacific ().\"\n", curDate)
    printf("---\n")

    printf("\n\n## [Stock Market Indexes - Google Finance](https://www.google.com/finance/markets/indexes/)\n\n")
    printf("| Index | Closing Value | Gain/Loss | Percentage Change |\n")
    printf("|---|---:|---:|---:|\n")
    }

function printTitle() {
    printf("\ntitle: \"%s: World Stock Market Closing Indexes: Americas (%s). Europe, Middle East, & Africa (%s). Asia Pacific (%s).\"\n", curDate, mktAmericas, mktEurope, mktAsia)
    }

function postTrailer() {

    printTitle()

    printWorldStockExchanges()
    printTrumpBusinesses()
    printFederalGovernment()
    printTrumpCrimeBusinesses()
    printTrumpStupidity()
    
    }
    
function printWorldStockExchanges() {  
    printf("\n### List of some of the major stock markets around the world and their locations:\n")
    printf("\n")
    printf("| Stock Exchange | Location |\n")
    printf("|---------------|----------|\n")
    printf("| **[New York Stock Exchange (NYSE)](https://www.nyse.com/index)** | New York City, USA |\n")
    printf("| **[Nasdaq Stock Market](https://www.nasdaq.com/)** | New York City, USA |\n")
    printf("| **[東京証券取引 (TSE)](https://www.jpx.co.jp/)** | Tokyo, Japan |\n")
    printf("| **[上海证券交易所 (SSE)](https://sse.com.cn/)** | Shanghai, China |\n")
    printf("| **[香港聯合交易所 (HKEX)](https://www.hkex.com.hk/)** | Hong Kong, China |\n")
    printf("| **[London Stock Exchange (LSE)](https://www.londonstockexchange.com/)** | London, United Kingdom |\n")
    printf("| **[Euronext](https://www.euronext.com/)** | Amsterdam, Brussels, Dublin, Lisbon, Milan, Oslo, Paris |\n")
    printf("| **[Toronto Stock Exchange (TSX)](https://www.tmx.com/)** | Toronto, Canada |\n")
    printf("| **[नेशनल स्टॉक एक्सचेंज (NSE)](https://www.nseindia.com/)** | Mumbai, India |\n")
    printf("| **[बंबई स्टॉक एक्सचेंज (BSE)](https://www.bseindia.com/)** | Mumbai, India |\n")
    printf("| **[深圳证券交易所 (SZSE)](https://www.szse.cn/)** | Shenzhen, China |\n")
    printf("| **[السوق المالية السعودية (تداول)](https://www.saudiexchange.sa/)** | Riyadh, Saudi Arabia |\n")
    printf("| **[Australian Securities Exchange (ASX)](https://www.asx.com.au/)** | Sydney, Australia |\n")
    printf("| **[Deutsche Börse (Frankfurt Stock Exchange)](https://www.deutsche-boerse.com/dbg-en)** | Frankfurt, Germany |\n")
    printf("| **[SIX Swiss Exchange](https://www.six-group.com/)** | Zurich, Switzerland |\n")
    printf("| **[한국거래소 (KRX)](https://www.krx.co.kr/)** | Seoul, South Korea |\n")
    printf("| **[臺灣證券交易所 (TWSE)](https://www.twse.com.tw/)** | Taipei, Taiwan |\n")
    printf("| **[Johannesburg Stock Exchange (JSE)](https://www.jse.co.za/)** | Johannesburg, South Africa |\n")
    printf("| **[首页](https://www.bursamalaysia.com/)** | Kuala Lumpur, Malaysia |\n")
    printf("| **[ตลาดหลักทรัพย์แห่งประเทศไทย (SET)](https://www.set.or.th/)** | Bangkok, Thailand |\n")
    printf("| **[新加坡交易所 (SGX)](https://www.sgx.com/)** | Singapore |\n")
    printf("| **[Bolsa Mexicana de Valores (BMV)](https://www.bmv.com.mx/)** | Mexico City, Mexico |\n")
    printf("| **[Московская Биржа (MOEX)](https://www.moex.com/)** | Moscow, Russia |\n")
    printf("| **[A Bolsa do Brasil (B3)](https://www.b3.com.br/)** | São Paulo, Brazil |\n")
    }

function printTrumpBusinesses() {
    printf("\n")
    printf("### Where Can Trump Be Found?\n")
    printf("\n")
    printf("#### Where Trump Pretends To Work\n")
    printf("\n")
    printf("| Where Trump Pretends To Work |\n")
    printf("|---|\n")
    printf("| **[White House](https://www.whitehouse.gov)** |\n")
    printf("| 1600 Pennsylvania Ave., NW <br /> Washington, DC 20500 <br /> <a href=\"tel:+12024561111\">+1 (202) 456-1111</a> (comments) <br /> <a href=\"tel:+12024561414\">+1 (202) 456-1414</a> (switchboard) |\n")
    printf("\n")
    printf("#### If It’s The Weekend, Find Trump On One Of His Golf Courses\n")
    printf("\n")
    printf("| Where Trump Can Be Found On Weekends |\n")
    printf("|---|\n")
    printf("| **[Mar-a-Lago](https://www.maralagoclub.com/)** |\n")
    printf("| [The Mar-a-Lago Club](https://www.maralagoclub.com/) <br /> 1100 South Ocean Boulevard, <br /> Palm Beach, Florida 33480 <br /> <a href=\"tel+15618322600\">+1 (561) 832-2600</a> |\n")
    printf("| **Florida, West Palm Beach** |\n")
    printf("| **[Trump International Golf Club](https://www.trumpinternationalpalmbeaches.com/)** <br /> 3505 Summit Blvd <br /> West Palm Beach FL 33406 <br /> <a href=\"tel:+15616820700\">+1 (561) 682-0700</a> |\n")
    printf("| **California, Los Angeles** |\n")
    printf("| **[Trump National Golf Club Los Angeles](https://www.trumpnationallosangeles.com/)** <br /> One Trump National Drive <br /> Rancho Palos Verdes, CA 90275 <br /> <a href=\"tel:+13102655000\">+1 (310) 265-5000</a> |\n")
    printf("| **Florida, Miami** |\n")
    printf("| **[Trump National Doral Golf Club](https://www.trumpgolfdoral.com/)** <br /> 4400 N.W. 87th Ave <br /> Miami, FL 33178 <br /> <a href=\"tel:+13055922000\">+1 (305) 592-2000</a> |\n")
    printf("| **Florida, Jupiter** |\n")
    printf("| **[Trump National Jupiter Golf Club](https://www.trumpnationaljupiter.com/about)** <br /> 115 Eagle Tree Terrace <br /> Jupiter FL 33477 <br /> <a href=\"tel:+15616918700\">+1 (561) 691-8700</a> |\n")
    printf("| **New Jersey, Bedminster** |\n")
    printf("| **[Trump National Golf Club Bedminster](https://www.trumpnationalbedminster.com/)** <br /> 900 Lamington Road <br /> Bedminster, NJ 07921 <br /> <a href=\"tel:+19084704400\">+1 (908) 470-4400</a> |\n")
    printf("| **New Jersey, Colts Neck** |\n")
    printf("| **[Trump National Golf Club Colts Neck](https://www.trumpcoltsneck.com/)** <br /> One Trump National Blvd <br /> Colts Neck, NJ 07722 <br /> <a href=\"tel:+15619731550\">+1 (561) 973-1550</a> |\n")
    printf("| **New Jersey, Pine Hill** |\n")
    printf("| **[Trump National Golf Club Philadelphia](https://www.trumpnationalphiladelphia.com/)** <br /> 500 West Branch Ave. <br /> Pine Hill, NJ 08021 <br /> <a href=\"tel:+18564353100\">+1 (856) 435-3100</a> |\n")
    printf("| **New York, Hopewell Junction** |\n")
    printf("|  **[Trump National Golf Club Hudson Valley](https://www.trumpnationalhudsonvalley.com/)** <br /> 178 Stormville Rd <br /> Hopewell Junction, NY 12533 <br /> <a href=\"tel:+18452231600\">+1 (845) 223-1600</a> |\n")
    printf("| **New York, Briarcliff Manor** |\n")
    printf("| **[Trump National Golf Club Westchester](https://www.trumpnationalwestchester.com/)** <br /> 100 Shadow Tree Lane <br /> Briarcliff Manor, NY 10510 <br /> <a href=\"tel:+19149440900\">+1 (914) 944-0900</a> |\n")
    printf("| **North Carolina, Mooresville** |\n")
    printf("| **[Trump National Golf Club Charlotte](https://www.trumpnationalcharlotte.com/)** <br /> 120 Trump Square <br /> Mooresville, NC 28117 <br /> <a href=\"tel:+17047997300\">+1 (704) 799-7300</a> |\n")
    printf("| **Virginia, Potomac Falls** |\n")
    printf("| **[Trump National Golf Club Washington, D.C.](https://www.trumpnationaldc.com/)** <br /> 20391 Lowes Island Blvd <br /> Potomac Falls, VA 20165 <br /> <a href=\"tel:+17034444801\">+1 (703) 444-4801</a> |\n")
    printf("| **Dubai** |\n")
    printf("| **[Trump International Golf Club Dubai](https://www.trumpgolfdubai.com/)** <br /> DAMAC Hills <br /> Al Hebiah Third District Dubai <br /> <a href=\"tel:+971042453939\">+971 (0) 4 245 3939</a> |\n")
    printf("| **Ireland, Clare** |\n")
    printf("| **[Trump International Golf Links & Hotel Ireland, Doonbeg](https://www.trumpgolfireland.com/)** <br />  DOONBEG CO. <br /> CLARE, IRELAND <br /> Phone: <a href=\"tel:+353659055600\">+353 65 905 5600</a> |\n")
    printf("| **Scotland, Aberdeenshire** |\n")
    printf("| **[Trump International Scotland](https://www.trumpgolfscotland.com/)** <br /> Menie Estate Balmedie <br /> Aberdeenshire, Scotland AB23 8YE <br /> Phone: <a href=\"tel:+441358743300\">+44 (0)1358 743 300</a> |\n")
    printf("| **Scotland, Ayrshire** |\n")
    printf("| **[Trump Turnberry](https://www.turnberry.co.uk/)** <br /> Maidens Road KA26 9LT Turnberry <br /> Ayrshire Scotland <br /> <a href=\"tel:+441655331000\">+44.1655.331.000</a> <br /> <a href=\"tel:+4401655334115\">+44 01655 334115</a> |\n")
    }

function printFederalGovernment() {
    printf("\n")
    printf("- [Constitution of the United States](https://constitution.congress.gov/)\n")
    printf("- [Supreme Court of the United States (SCOTUS)](https://www.supremecourt.gov/)\n")
    printf("- [US Courts](https://www.uscourts.gov/)\n")
    printf("- [Federal Reserve Board](https://www.federalreserve.gov/)\n")
    printf("- [Jerome H. Powell](https://www.federalreserve.gov/aboutthefed/bios/board/powell.htm)\n")
    printf("- [Department of Commerce (DOC)](https://www.commerce.gov/)\n")
    printf("- [Treasury Department](https://home.treasury.gov/)\n")
    printf("- [Senate](https://www.senate.gov/)\n")
    printf("- [House of Representatives](https://www.house.gov/)\n")
    printf("- [U.S. Department of the Treasury](https://home.treasury.gov/)\n")
    printf("- [Department of Commerce (DOC)](https://www.commerce.gov/)\n")
    printf("- [President of the United States (POTUS)](https://www.whitehouse.gov/)\n")
    printf("- [White House (WH)](https://www.whitehouse.gov/)\n")
    }

function printTrumpCrimeBusinesses() {
    printf("- Trump crime businesses \n")
    printf("- [Trump Organization](https://www.trump.com/)\n")
    printf("- [World Liberty Financial](https://www.worldlibertyfinancial.com/)\n")
    printf("- [$TRUMP](https://gettrumpmemes.com/)\n")
    printf("- [$MELANIA](https://melaniameme.com/)\n")
        printf("- [The Mar-a-Lago Club](https://www.maralagoclub.com/) \n")
    printf("- [Trump International Golf Club](https://www.trumpinternationalpalmbeaches.com/) \n")
    printf("- [Trump National Doral Golf Club](https://www.trumpgolfdoral.com/) \n")
    printf("- [Trump National Jupiter Golf Club](https://www.trumpnationaljupiter.com/) \n")
    printf("- [Trump National Golf Club Washington, D.C.](https://www.trumpnationaldc.com/)\n")
    printf("- [Trump National Golf Club Bedminster](https://www.trumpnationalbedminster.com/) \n")
    printf("- [Trump National Golf Club Colts Neck](https://www.trumpcoltsneck.com/) \n")
    printf("- [Trump National Golf Club Philadelphia](https://www.trumpnationalphiladelphia.com/) \n")
    printf("- [Trump National Golf Club Hudson Valley](https://www.trumpnationalhudsonvalley.com/) \n")
    printf("- [Trump National Golf Club Westchester](https://www.trumpnationalwestchester.com/) \n")
    printf("- [Trump National Golf Club Los Angeles](https://www.trumpnationallosangeles.com/) \n")
    printf("- [Trump International Golf Club Dubai](https://www.trumpgolfdubai.com/) \n")
    printf("- [Trump International Golf Links & Hotel Ireland, Doonbeg](https://www.trumpgolfireland.com/) \n")
    printf("- [Trump MacLeod House & Lodge Scotland](https://www.trumphotels.com/macleod-house)\n")
    printf("- [Trump Turnberry](https://www.turnberry.co.uk/)\n")
    printf("- Trump crime family\n")
    printf("- [Donald J Trump](https://www.donaldjtrump.com/)\n")
    printf("- [Eric F. Trump / LinkedIn](https://www.linkedin.com/in/erictrump/)\n")
    printf("- [Donald Trump Jr. / LinkedIn](https://www.linkedin.com/in/donald-trump-jr-4454b862/)\n")
    printf("- Ivanka Trump\n")
    printf("- Jared Kushner\n")
    printf("- [Howard Lutnick](https://www.commerce.gov/about/leadership/howard-lutnick)\n")
    printf("- [Howard W. Lutnick](https://www.linkedin.com/in/howardwlutnick/)\n")
    printf("- [Scott Bessent](https://home.treasury.gov/about/general-information/officials/scott-bessent)\n")
    }

function printTrumpStupidity() {
#    printf("\n")
    printf("- [Further Modifying the Reciprocal Tariff Rates](https://www.whitehouse.gov/presidential-actions/2025/07/further-modifying-the-reciprocal-tariff-rates/). Presidential Actions, Executive Orders. July 31, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Amends Duties to Address the Flow of Illicit Drugs Across our Northern Border](https://www.whitehouse.gov/fact-sheets/2025/07/fact-sheet-president-donald-j-trump-amends-duties-to-address-the-flow-of-illicit-drugs-across-our-northern-border/). Fact Sheets. July 31, 2025.\n")
    printf("- [Fact Sheet: President Donald J. Trump Further Modifies the Reciprocal Tariff Rates](https://www.whitehouse.gov/fact-sheets/2025/07/fact-sheet-president-donald-j-trump-further-modifies-the-reciprocal-tariff-rates/). Fact Sheets. July 31, 2025.\n")
    printf("- [Addressing Threats to The United States by the Government of Brazil](https://www.whitehouse.gov/presidential-actions/2025/07/addressing-threats-to-the-us/). Presidential Actions, Executive Orders. July 30, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Addresses Threats to the United States from the Government of Brazil](https://www.whitehouse.gov/fact-sheets/2025/07/fact-sheet-president-donald-j-trump-addresses-threats-to-the-united-states-from-the-government-of-brazil/). Fact Sheets. July 30, 2025\n")
    printf("- [Suspending Duty-Free De Minimis Treatment for All Countries](https://www.whitehouse.gov/presidential-actions/2025/07/suspending-duty-free-de-minimis-treatment-for-all-countries/). Presidential Actions, Executive Orders. July 30, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump is Protecting the United States’ National Security and Economy by Suspending the De Minimis Exemption for Commercial Shipments Globally](https://www.whitehouse.gov/fact-sheets/2025/07/fact-sheet-president-donald-j-trump-is-protecting-the-united-states-national-security-and-economy-by-suspending-the-de-minimis-exemption-for-commercial-shipments-globally/). Fact Sheets. July 30, 2025\n")
    printf("- [Adjusting Imports of Copper into the United States](https://www.whitehouse.gov/presidential-actions/2025/07/adjusting-imports-of-copper-into-the-united-states/). Presidential Actions, Proclamations July 30, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Takes Action to Address the Threat to National Security from Imports of Copper](https://www.whitehouse.gov/fact-sheets/2025/07/fact-sheet-president-donald-j-trump-takes-action-to-address-the-threat-to-national-security-from-imports-of-copper/). Fact Sheets July 30, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Continues Enforcement of Reciprocal Tariffs and Announces New Tariff Rates](https://www.whitehouse.gov/fact-sheets/2025/07/fact-sheet-president-donald-j-trump-continues-enforcement-of-reciprocal-tariffs-and-announces-new-tariff-rates/). Fact Sheets. July 7, 2025\n")
    printf("- [Extending the Modification of the Reciprocal Tariff Rates](https://www.whitehouse.gov/presidential-actions/2025/07/extending-the-modification-of-the-reciprocal-tariff-rates/). Presidential Actions, Executive Orders. July 7, 2025\n")
    printf("- [Extending the Modification of the Reciprocal Tariff Rates](https://www.whitehouse.gov/presidential-actions/2025/07/extending-the-modification-of-the-reciprocal-tariff-rates/). Presidential Actions, Executive Orders. July 7, 2025\n")
    printf("- [Implementing the General Terms of The United States of America-United Kingdom Economic Prosperity Deal](https://www.whitehouse.gov/presidential-actions/2025/06/implementing-the-general-terms-of-the-united-states-of-america-united-kingdom-economic-prosperity-deal/). Presidential Actions, Executive Orders. June 16, 2025\n")
        printf("- [Fact Sheet: Implementing the General Terms of the U.S.-UK Economic Prosperity Deal](https://www.whitehouse.gov/fact-sheets/2025/06/fact-sheet-implementing-the-general-terms-of-the-u-s-uk-economic-prosperity-deal/). Fact Sheets. June 17, 2025\n")
        printf("- [Fact Sheet: President Donald J. Trump Increases Section 232 Tariffs on Steel and Aluminum](https://www.whitehouse.gov/fact-sheets/2025/06/fact-sheet-president-donald-j-trump-increases-section-232-tariffs-on-steel-and-aluminum/). Fact Sheets. June 3, 2025\n")
    printf("- [Adjusting Imports of Aluminum and Steel into the United States](https://www.whitehouse.gov/presidential-actions/2025/06/adjusting-imports-of-aluminum-and-steel-into-the-united-states/). Proclamations. June 3, 2025\n")
    printf("- [Modifying Reciprocal Tariff Rates to Reflect Discussions with the People’s Republic of China](https://www.whitehouse.gov/presidential-actions/2025/05/modifying-reciprocal-tariff-rates-to-reflect-discussions-with-the-peoples-republic-of-china/). Presidential Actions, Executive Orders. May 12, 2025\n")
    printf("- [Amendments to Adjusting Imports of Automobiles and Automobile Parts Into the United States](https://www.whitehouse.gov/presidential-actions/2025/04/amendments-to-adjusting-imports-of-automobiles-and-automobile-parts-into-the-united-states/). Presidential Actions, Proclamations. April 29, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Incentivizes Domestic Automobile Production](https://www.whitehouse.gov/fact-sheets/2025/04/fact-sheet-president-donald-j-trump-incentivizes-domestic-automobile-production/). Fact Sheets. April 29, 2025\n")
    printf("- [Ensuring National Security and Economic Resilience Through Section 232 Actions on Processed Critical Minerals and Derivative Products](https://www.whitehouse.gov/presidential-actions/2025/04/ensuring-national-security-and-economic-resilience-through-section-232-actions-on-processed-critical-minerals-and-derivative-products/). Presidential Actions, Executive Orders. April 15, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Ensures National Security and Economic Resilience Through Section 232 Actions on Processed Critical Minerals and Derivative Products](https://www.whitehouse.gov/fact-sheets/2025/04/fact-sheet-president-donald-j-trump-ensures-national-security-and-economic-resilience-through-section-232-actions-on-processed-critical-minerals-and-derivative-products/). Fact Sheets. April 15, 2025\n")
    printf("- [Clarification of Exceptions Under Executive Order 14257 of April 2, 2025, as Amended – The White House](https://www.whitehouse.gov/presidential-actions/2025/04/clarification-of-exceptions-under-executive-order-14257-of-april-2-2025-as-amended/). Presidential Actions, Presidential Memoranda. April 11, 2025\n")
    printf("- [Modifying Reciprocal Tariff Rates to Reflect Trading Partner Retaliation and Alignment](https://www.whitehouse.gov/presidential-actions/2025/04/modifying-reciprocal-tariff-rates-to-reflect-trading-partner-retaliation-and-alignment/). Presidential Actions, Executive Orders April 9, 2025\n")
    printf("- [Amendment to Reciprocal Tariffs and Updated Duties as Applied to Low-Value Imports from the People’s Republic of China](https://www.whitehouse.gov/presidential-actions/2025/04/amendment-to-recipricol-tariffs-and-updated-duties-as-applied-to-low-value-imports-from-the-peoples-republic-of-china/). Presidential Actions, Executive Orders. April 8, 2025\n")
    printf("- [Report to the President on the America First Trade Policy Executive Summary](https://www.whitehouse.gov/fact-sheets/2025/04/report-to-the-president-on-the-america-first-trade-policy-executive-summary/). Fact Sheets. April 3, 2025\n")
    printf("- [Regulating Imports with a Reciprocal Tariff to Rectify Trade Practices that Contribute to Large and Persistent Annual United States Goods Trade Deficits](https://www.whitehouse.gov/presidential-actions/2025/04/regulating-imports-with-a-reciprocal-tariff-to-rectify-trade-practices-that-contribute-to-large-and-persistent-annual-united-states-goods-trade-deficits/). Presidential Actions, Executive Orders. April 2, 2025\n")
    printf("- [Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China as Applied to Low-Value Imports](https://www.whitehouse.gov/presidential-actions/2025/04/further-amendment-to-duties-addressing-the-synthetic-opioid-supply-chain-in-the-peoples-republic-of-china-as-applied-to-low-value-imports/). Presidential Actions, Executive Orders. April 2, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Declares National Emergency to Increase our Competitive Edge, Protect our Sovereignty, and Strengthen our National and Economic Security](https://www.whitehouse.gov/fact-sheets/2025/04/fact-sheet-president-donald-j-trump-declares-national-emergency-to-increase-our-competitive-edge-protect-our-sovereignty-and-strengthen-our-national-and-economic-security/). Fact Sheets. April 2, 2025\n")
    printf("- [Regulating Imports with a Reciprocal Tariff to Rectify Trade Practices that Contribute to Large and Persistent Annual United States Goods Trade Deficits](https://www.whitehouse.gov/presidential-actions/2025/04/regulating-imports-with-a-reciprocal-tariff-to-rectify-trade-practices-that-contribute-to-large-and-persistent-annual-united-states-goods-trade-deficits/). Presidential Actions, Executive Orders. April 2, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Closes De Minimis Exemptions to Combat China’s Role in America’s Synthetic Opioid Crisis](https://www.whitehouse.gov/fact-sheets/2025/04/fact-sheet-president-donald-j-trump-closes-de-minimis-exemptions-to-combat-chinas-role-in-americas-synthetic-opioid-crisis/). Fact Sheets. April 2, 2025\n")
    printf("- [Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China as Applied to Low-Value Imports](https://www.whitehouse.gov/presidential-actions/2025/04/further-amendment-to-duties-addressing-the-synthetic-opioid-supply-chain-in-the-peoples-republic-of-china-as-applied-to-low-value-imports/). Presidential Actions, Executive Orders. April 2, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Adjusts Imports of Automobiles and Automobile Parts into the United States](https://www.whitehouse.gov/fact-sheets/2025/03/fact-sheet-president-donald-j-trump-adjusts-imports-of-automobiles-and-automobile-parts-into-the-united-states/). Fact Sheets. March 26, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Imposes Tariffs on Countries Importing Venezuelan Oil](https://www.whitehouse.gov/fact-sheets/2025/03/fact-sheet-president-donald-j-trump-imposes-tariffs-on-countries-importing-venezuelan-oil/). Fact Sheets. March 25, 2025\n")
    printf("- [Imposing Tariffs on Countries Importing Venezuelan Oil](https://www.whitehouse.gov/presidential-actions/2025/03/imposing-tariffs-on-countries-importing-venezuelan-oil/). Presidential Actions, Executive Orders. March 24, 2025\n")
    printf("- [Amendment to Duties to Address the Flow of Illicit Drugs Across Our Southern Border](https://www.whitehouse.gov/presidential-actions/2025/03/amendment-to-duties-to-address-the-flow-of-illicit-drugs-across-our-southern-border/). Presidential Actions. March 6, 2025\n")
    printf("- [Amendment to Duties to Address the Flow of Illicit Drugs Across Our Northern Border](https://www.whitehouse.gov/presidential-actions/2025/03/amendment-to-duties-to-address-the-flow-of-illicit-drugs-across-our-northern-border-0c3c/). Presidential Actions March 6, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Proceeds with Tariffs on Imports from Canada and Mexico](https://www.whitehouse.gov/fact-sheets/2025/03/fact-sheet-president-donald-j-trump-proceeds-with-tariffs-on-imports-from-canada-and-mexico/). Fact Sheets. March 3, 2025\n")
    printf("- [Further Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China](https://www.whitehouse.gov/presidential-actions/2025/03/further-amendment-to-duties-addressing-the-synthetic-opioid-supply-chain-in-the-peoples-republic-of-china/). Presidential Actions. March 3, 2025\n")
    printf("- [Amendment to Duties to Address the Situation at our Southern Border](https://www.whitehouse.gov/presidential-actions/2025/03/amendment-to-duties-to-address-the-situation-at-our-southern-border/). Presidential Actions March 2, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Addresses the Threat to National Security from Imports of Timber, Lumber, and their Derivative Products](https://www.whitehouse.gov/fact-sheets/2025/03/fact-sheet-president-donald-j-trump-addresses-the-threat-to-national-security-from-imports-of-timber-lumber-and-their-derivative-products/). Fact Sheets. March 1, 2025\n")
    printf("- [Addressing the Threat to National Security from Imports of Timber, Lumber](https://www.whitehouse.gov/presidential-actions/2025/03/addressing-the-threat-to-national-security-from-imports-of-timber-lumber/). Presidential Actions. March 1, 2025\n")
    printf("- [Addressing the Threat to National Security from Imports of Copper](https://www.whitehouse.gov/presidential-actions/2025/02/addressing-the-threat-to-nationalsecurity-from-imports-of-copper/). Presidential Actions February 25, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Addresses the Threat to National Security from Imports of Copper](https://www.whitehouse.gov/fact-sheets/2025/02/fact-sheet-president-donald-j-trump-addresses-the-threat-to-national-security-from-imports-of-copper/). Fact Sheets. February 25, 2025\n")
    printf("- [Defending American Companies and Innovators From Overseas Extortion and Unfair Fines and Penalties](https://www.whitehouse.gov/presidential-actions/2025/02/defending-american-companies-and-innovators-from-overseas-extortion-and-unfair-fines-and-penalties/). Presidential Actions February 21, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Issues Directive to Prevent the Unfair Exploitation of American Innovation](https://www.whitehouse.gov/fact-sheets/2025/02/fact-sheet-president-donald-j-trump-issues-directive-to-prevent-the-unfair-exploitation-of-american-innovation/). Fact Sheets. February 21, 2025\n")
    printf("- [Remarks by President Trump at Republican Governors Association Meeting](https://www.whitehouse.gov/remarks/2025/02/remarks-by-president-trump-at-republican-governors-association-meeting/). Remarks February 20, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Announces “Fair and Reciprocal Plan” on Trade](https://www.whitehouse.gov/fact-sheets/2025/02/fact-sheet-president-donald-j-trump-announces-fair-and-reciprocal-plan-on-trade/). Fact Sheets. February 13, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Restores Section 232 Tariffs](https://www.whitehouse.gov/fact-sheets/2025/02/fact-sheet-president-donald-j-trump-restores-section-232-tariffs/). Fact Sheets. February 11, 2025\n")
    printf("- [Adjusting Imports of Aluminum into The United States](https://www.whitehouse.gov/presidential-actions/2025/02/adjusting-imports-of-aluminum-into-the-united-states/). Presidential Actions. February 11, 2025\n")
    printf("- [Adjusting Imports of Steel into The United States](https://www.whitehouse.gov/presidential-actions/2025/02/adjusting-imports-of-steel-into-the-united-states/). Presidential Actions. February 10, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Restores American Competitiveness and Security in FCPA Enforcement](https://www.whitehouse.gov/fact-sheets/2025/02/fact-sheet-president-donald-j-trump-restores-american-competitiveness-and-security-in-fcpa-enforcement/). Fact Sheets. February 10, 2025\n")
    printf("- [Amendment to Duties Addressing the Synthetic Opioid Supply Chain in the People’s Republic of China](https://www.whitehouse.gov/presidential-actions/2025/02/amendment-to-duties-addressing-the-synthetic-opioid-supply-chain-in-the-peoples-republic-of-china/). Presidential Actions February 5, 2025\n")
    printf("- [Progress on the Situation at Our Northern Border](https://www.whitehouse.gov/presidential-actions/2025/02/progress-on-the-situation-at-our-northern-border/). Presidential Actions. February 3, 2025\n")
    printf("- [Progress on the Situation at Our Southern Border](https://www.whitehouse.gov/presidential-actions/2025/02/progress-on-the-situation-at-our-southern-border/). Presidential Actions. February 3, 2025\n")
    printf("- [Imposing Duties to Address the Synthetic Opioid Supply Chain in the People’s Republic of China](https://www.whitehouse.gov/presidential-actions/2025/02/imposing-duties-to-address-the-synthetic-opioid-supply-chain-in-the-peoples-republic-of-china/). Presidential Actions. February 1, 2025\n")
    printf("- [Imposing Duties to Address the Flow of Illicit Drugs Across Our Northern Border](https://www.whitehouse.gov/presidential-actions/2025/02/imposing-duties-to-address-the-flow-of-illicit-drugs-across-our-national-border/). Presidential Actions. February 1, 2025\n")
    printf("- [Fact Sheet: President Donald J. Trump Imposes Tariffs on Imports from Canada, Mexico and China](https://www.whitehouse.gov/fact-sheets/2025/02/fact-sheet-president-donald-j-trump-imposes-tariffs-on-imports-from-canada-mexico-and-china/). Fact Sheets February 1, 2025\n")
    printf("- [Imposing Duties to Address the Situation at Our Southern Border](https://www.whitehouse.gov/presidential-actions/2025/02/imposing-duties-to-address-the-situation-at-our-southern-border/). Presidential Actions. February 1, 2025\n")
    printf("- [America First Trade Policy](https://www.whitehouse.gov/presidential-actions/2025/01/america-first-trade-policy/). Presidential Actions January 20, 2025\n")
    printf("- tariffs\n")
    printf("- politics\n")
    printf("- stupidity\n")
    }
