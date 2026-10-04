//01 @RalphHightower: Since this is a comma centric file, I added a comma after the comment slashes and between the latitude and longitude.
//02 GPS coordinates were gotten from Wikipedia.
//03 Shared civilian/military airport rule:
//04 Civilian airports use the [IATA code](https://en.wikipedia.org/wiki/IATA_airport_code?wprov=sfla1) and civilian website.
//05 Military airports use the [ICAO code](https://en.wikipedia.org/wiki/ICAO_airport_code?wprov=sfla1) and military website
const iataDatabase = {
    ABE: { name: "Lehigh Valley International Airport", link: "https://www.flyabe.com/", lat: 0.709517, lon: -1.316685 }, //, 40°39′08.4″N, 075°26′25.7″W
    ADW: { name: "Joint Base Andrews", link: "https://www.jba.af.mil/", lat: 0.677377, lon: -1.341581 }, //, 38°48′39″N, 076°52′01″W
    AKH: { name: "Gastonia Municipal Airport", link: "https://gastonianc.gov/municipal-airport.html", lat: 0.614404, lon: -1.416330 }, //, 35°12′10″N, 081°08′59″W
    ANC: { name: "Ted Stevens Anchorage International Airport", link: "https://dot.alaska.gov/anc/", lat: 1.067691, lon: -2.617965 }, //, 61°10′27″N, 149°59′54″W
    ANK: { name: "Etimesgut Air Base", link: "https://www.hvkk.tsk.tr", lat: 0.697256, lon: 0.570524 }, //, 39°56′59.39″N, 032°41′19.04″E
    ARB: { name: "Dobbins Air Reserve Base", link: "https://www.afrc.af.mil/dobbins/", lat: 0.591933, lon: -1.475089 }, //, 33°54′55″N, 084°30′59″W
    ATL: { name: "Hartsfield–Jackson Atlanta International Airport", link: "https://www.atl.com/", lat: 0.587071, lon: -1.473548 }, //🛫, 33°38′12″N, 84°25′41″W
    AUH: { name: "Abu Dhabi International Airport / Zayed International Airport", link: "https://www.zayedinternationalairport.ae/", lat: 0.426437, lon: 0.953842 }, //, 24°25′59″N, 054°39′04″E
    AVL: { name: "Asheville Regional Airport", link: "https://flyavl.com/", lat: 0.618477, lon: -1.440624 }, //, 35°26′10″N, 082°32′30″W
    BFM: { name: "Mobile International Airport", link: "https://www.mobileairportauthority.com/downtown/", lat: 0.534536, lon: -1.537078 }, //, 30°37'36"N, 088°04'05"W
    BIS: { name: "Bismarck Municipal Airport", link: "https://bismarckairport.com/", lat: 0.816339, lon: -1.758346 }, //, 46°46′22″N, 100°44′45″W
    CAE: { name: "Columbia Metropolitan Airport", link: "https://flycae.com/", lat: 0.592345, lon: -1.415801 }, //🛫, 33°56′20″N, 081°07′10″W
    CHS: { name: "Charleston International Airport", link: "https://iflychs.com/", lat: 0.574189, lon: -1.396971 }, //, 32°53′55″N, 080°02′26″W
    CID: { name: "Eastern Iowa Airport / Cedar Rapids Airport", link: "https://flycid.com/", lat: 0.731026, lon: -1.600656 }, //🛫, 41°53′04.9″N, 91°42′38.9″W
    CLE: { name: "Cleveland Hopkins International Airport", link: "https://www.clevelandairport.com/", lat: 0.722770, lon: 1.428547 }, //, 41°24′42″N, 081°50′59″
    CLT: { name: "Charlotte Douglas International Airport", link: "https://www.cltairport.com/", lat: 0.614598, lon: -1.412723 }, //🛫, 35°12′50″N, 080°56′35″W
    CMH: { name: "John Glenn Columbus International Airport", link: "https://flycolumbus.com/", lat: 0.698098, lon: -1.446737 }, //🛫, 39°59′53″N, 082°53′31″W
    CPR: { name: "Casper–Natrona County International Airport", link: "https://iflycasper.com/", lat: 0.748887, lon: -1.858155 }, //, 42°54′29″N, 106°27′52″W
    CRP: { name: "Corpus Christi International Airport", link: "https://corpuschristiairport.com/", lat: 0.484683, lon: -1.701715 }, //, 27°46′13″N, 097°30′04″W
    CVG: { name: "Cincinnati/Northern Kentucky International Airport", link: "https://www.cvgairport.com/", lat: 0.681532, lon: -1.477731 }, //🛫, 39°02′56″N, 084°40′04″W
    DAB: { name: "Daytona Beach International Airport", link: "https://www.flydaytonafirst.com/", lat: 0.509369, lon: -1.414774 }, //, 29°11′05″N, 81°03′38″W
    DAY: { name: "James M. Cox Dayton International Airport", link: "https://flydayton.com/", lat: 0.696425, lon: -1.469907 }, //🛫, 39°54′08″N, 84°13′10″W
    DFW: { name: "Dallas Fort Worth International Airport", link: "https://www.dfwairport.com/", lat: 0.574160, lon: -1.693634 }, //, 32°53′49″N, 97°02′17″W
    DJT: { name: "President Donald J. Trump International Airport", link: "https://flydjt.org/", lat: 0.465707, lon: -1.397931 }, //, 26°40′59″N, 80°05′44″W
    DMA: { name: "Davis-Monthan Air Force Base (The Boneyard)", link: "https://www.dover.af.mil/", lat: 0.561361, lon: -1.934688 }, //, 32°09′49″N, 110°50′58″W
    DOH: { name: "Hamad International Airport", link: "https://www.dohahamadairport.com/", lat: 0.441098, lon: 0.900730 }, //, 25°16′23″N, 51°36′29″E
    DOV: { name: "Dover Air Force Base", link: "https://www.dm.af.mil/", lat: 0.682918, lon: -1.317108 }, //, 39°07′42″N, 075°27′53″W
    DSM: { name: "Des Moines International Airport", link: "https://www.flydsm.com/", lat: 0.724903, lon: -1.634729 }, //, 41°32′02″N, 093°39′47″W
    DTW: { name: "Detroit Metropolitan Wayne County Airport", link: "https://metroairport.com/", lat: 0.736747, lon: -1.454790 }, //🛫, 42°12′45″N, 083°21′12″W
    DUB: { name: "Dublin International Airport", link: "https://www.dublinairport.com/", lat: 0.932379, lon: -0.109432 }, //, 53°25′17″N, 006°16′12″W
    EAU: { name: "Chippewa Valley Regional Airport", link: "https://www.chippewavalleyairport.com/", lat: 0.783057, lon: -1.596700 }, //, 44°51′57″N, 091°29′03″W
    EDF: { name: "Joint Base Elmendorf-Richardson", link: "https://www.jber.jb.mil/", lat: 1.069038, lon: -2.614615 }, //, 61°15′05″N, 149°48′23″W
    EFD: { name: "Ellington Field Joint Reserve Base", link: "https://www.147atkw.ang.af.mil/", lat: 0.516744, lon: -1.660836 }, //, 29°36′26″N, 095°09′32″W
    ERV: { name: "Kerrville Municipal Airport", link: "https://www.kerrvilletx.gov/1765/Airport", lat: 0.523192, lon: -1.729369 }, //, 29°58′36″N, 99°05′08″W
    ESB: { name: "Ankara Esenboğa Airport", link: "https://esenbogaairport.com/", lat: 0.700367, lon: 0.575871 }, //, 40°07′41″N, 032°59′42″E
    EWR: { name: "Newark Liberty International Airport", link: "https://www.newarkairport.com/", lat: 0.710218, lon: -1.294486 }, //, 40°41′33″N, 074°10′07″W
    FCO: { name: "Fiumicino Leonardo da Vinci International Airport / Rome Fiumicino Airport", link: "https://www.adr.it/", lat: 0.729552, lon: 0.213609 }, //, 41°48′01″N, 012°14′20″E
    FRG: { name: "Republic Airport", link: "https://republicairport.net/", lat: 0.710853, lon: -1.281304 }, //, 40°43′44″N, 073°24′48″W
    GON: { name: "Groton-New London Airport", link: "https://ctairports.org/airports/groton-newlondon/", lat: 0.721345, lon: -1.257422 }, //, 41°19′48″N, 072°02′42″W
    GSP: { name: "Greenville–Spartanburg International Airport", link: "https://gspairport.com/", lat: 0.609042, lon: -1.434990 }, //🛫, 34°53′44″N, 082°13′08″W
    GVA: { name: "Geneva Airport", link: "http://www.gva.ch/", lat: 0.806997, lon: 0.106625 }, //, 46°14′15″N, 6°06′33″E
    HGR: { name: "Hagerstown Regional Airport", link: "https://www.washco-md.net/hagerstown-regional-airport/", lat: 0.693046, lon: -1.356581 }, //, 39°42′31″N, 077°43′35″W
    HND: { name: "Haneda Airport", link: "https://tokyo-haneda.com/", lat: 0.620523, lon: 2.439641 }, //, 35°33′12″N, 139°46′52″E
    HNL: { name: "Daniel K. Inouye International Airport", link: "https://airports.hawaii.gov/hnl/", lat: 0.372080, lon: -2.756268 },	//, 21°19′07″N, 157°55′21″W
    HWO: { name: "North Perry Airport", link: "https://www.broward.org/NorthPerryAirport/Pages/Default.aspx", lat: 0.453805, lon: -1.400467 }, //, 26°00′04″N, 080°14′27″W
    IAD: { name: "Washington Dulles International Airport", link: "https://www.flydulles.com/", lat: 0.679709, lon: -1.351859 }, //, 38°56′40″N, 077°27′21″W
    JFK: { name: "John F. Kennedy International Airport", link: "https://johnfkennedyairport-jfk.com/", lat: 0.709297, lon: -1.287685 }, //, 40°38′23″N, 73°46′44″W
    JRB: { name: "Downtown Manhattan Heliport", link: "https://www.downtownskyportnyc.com/", lat: 0.710368, lon: -1.291697 }, //, 40.701116°N, 74.008801°W
    JYO: { name: "Leesburg Executive Airport", link: "https://www.leesburgva.gov/departments/airport/about-leesburg-executive-airport", lat: 0.682041, lon: -1.353634 }, //, 39°04′41″N, 077°33′27″W
    KCHS: { name: "Joint Base Lindsey Graham (Charleston)", link: "https://www.jbcharleston.jb.mil/", lat: 0.574189, lon: -1.396971 }, //, 32°53′55″N, 080°02′26″W
    KHNL: { name: "Joint Base Pearl Harbor–Hickam", link: "https://cnrh.cnic.navy.mil/Installations/JB-Pearl-Harbor-Hickam/", lat: 0.372080, lon: -2.756268 },	//, 21°19′07″N, 157°55′21″W
    KMMT: { name: "McEntire Joint National Guard Base", link: "https://www.169fw.ang.af.mil/", lat: 0.592030, lon: -1.410245 }, //, 33°55'15"N, 080°48'04"W
    KNBC: { name: "Marine Corps Air Station Beaufort", link: "https://www.beaufort.marines.mil/", lat: 0.566834, lon: -1.408883 }, //, 32°28'38"N, 080°43'23"W
    KRW: { name: "Rocky Mount-Wilson Regional Airport", link: "https://www.krwiairport.org/", lat: 0.625812, lon: -1.359471 }, //, 35°51′23″N, 077°53′31″W
    KSSC: { name: "Shaw Air Force Base", link: "https://www.shaw.af.mil/", lat: 0.592942, lon: -1.404515 }, 33°58'23"N, 080°28′22″W
    KUL: { name: "Kuala Lumpur International Airport", link: "https://www.kuala-lumpur-airport.com/", lat: 0.047880, lon: 1.774966 }, //, 02°44′36″N, 101°41′53″E
    LAS: { name: "Harry Reid International Airport", link: "https://www.harryreidairport.com/)", lat: 0.629715, lon: -2.009785 }, //, 36°04′48″N, 115°09′08″W
    LAX: { name: "Los Angeles International Airport", link: "https://www.flylax.com/", lat: 0.592408, lon: -2.066610 }, //, 33°56′33″N, 118°24′29″W
    LGA: { name: "LaGuardia Airport", link: "https://www.laguardiaairport.com/", lat: 0.711658, lon: -1.289362 }, //, 40°46′30″N, 73°52′30″W
    LMO: { name: "RAF Lossiemouth", link: "https://www.raf.mod.uk/our-organisation/stations/raf-lossiemouth/", lat: 1.007147, lon: -0.058279 }, //, 57°42′19″N, 003°20′21″W
    LUF: { name: "Luke Air Force Base", link: "https://www.luke.af.mil/", lat: 0.585296, lon: -1.961454 }, //, 33°32′06″N, 112°22′59″W
    MCI: { name: "Kansas City International Airport", link: "https://flykc.com/", lat: 0.685871, lon: -1.653069 }, //, 39°17′51″N, 94°42′50″W
    MEM: { name: "Memphis International Airport", link: "https://flymemphis.com/", lat: 0.611607, lon: -1.570389 }, //🛫, 35°02′33″N, 089°58′36″W
    MHZ: { name: "RAF Mildenhall / Royal Air Force Mildenhall", link: "https://www.mildenhall.af.mil/", lat: 0.913942, lon: 0.008392 }, //, 52°21′54″N, 000°28′51″E
    MIA: { name: "Miami International Airport", link: "https://miami-airport.com/", lat: 0.450179, lon: -1.401335 }, //, 25°47′36″N, 080°17′26″W
    MMU: { name: "Morristown Municipal Airport", link: "https://www.mmuair.com/", lat: 0.712085, lon: -1.298787 }, //, 40°47′58″N, 074°24′54″W
    MTC: { name: "Selfridge Air National Guard Base", link: "https://www.127wg.ang.af.mil/", lat: 0.743656, lon: -1.445753 }, //, 42°36′30″N, 082°50′08″W
    MYR: { name: "Myrtle Beach International Airport", link: "https://www.flymyrtlebeach.com/", lat: 0.587822, lon: -1.377559 }, //, 33°40′47″N, 078°55′42″W
    OMA: { name: "Eppley Airfield / Omaha Airport", link: "https://www.flyoma.com/", lat: 0.720821, lon: -1.673683 }, //, 41.30°N, 95.895°W
    ORD: { name: "Chicago O'Hare International Airport", link: "https://www.flychicago.com/ohare/", lat: 0.732665, lon: -1.534227 }, //🛫, 41°58′43″N, 87°54′17″W
    ORY: { name: "Aéroport Paris-Orly - Paris Aéroport", link: "https://www.parisaeroport.fr/en/passengers/orly-airport", lat: 0.850383, lon: 0.041529 }, //, 48°43'24"N, 02°22'46"E
    PBI: { name: "Palm Beach International Airport", link: "https://www.pbia.org/", lat: 0.465707, lon: -1.397931 }, //, 26°40′59″N, 80°05′44″W
    PEB: { name: "Teterboro Airport", link: "https://www.panynj.gov/airports/en/teterboro.html", lat: 0.712967, lon: -1.292605 }, //, 40°51′00″N, 074°03′39″W
    PEK: { name: "Beijing Capital International Airport", link: "https://www.bcia.com.cn/", lat: 0.699397, lon: 2.035010 }, //, 40°04′21″N, 116°35′51″E
    PHL: { name: "Philadelphia International Airport", link: "https://www.phl.org/", lat: 0.695897, lon: -1.313205 }, //🛫, 39°52′19″N, 075°14′28″W
    PIK: { name: "Glasgow Prestwick Airport", link: "https://www.glasgowprestwick.com/", lat: 0.968823, lon: -0.080188 }, //, 55°30′34″N, 004°35′40″W
    PIT: { name: "Pittsburgh International Airport", link: "https://flypittsburgh.com/", lat: 0.706789, lon: -1.400557 }, //🛫, 40.496°N, 80.246°W
    POB: { name: "Pope Field", link: "https://www.pope.af.mil/", lat: 0.613847, lon: -1.379062 }, //, 35°10′15″N, 79°00′52″W
    PTK: { name: "Oakland County International Airport", link: "https://www.oakgov.com/community/airports/oakland-county-international-airport", lat: 0.744654, lon: -1.455959 }, //, 42°39'56"N, 083°25'13"W
    PUS: { name: "Gimhae International Airport", link: "https://gimhaeairport.com/", lat: 0.613997, lon: 2.250398 }, //, 35°10′46″N, 128°56′18″E
    PVD: { name: "Rhode Island T. F. Green International Airport", link: "https://flyri.com/", lat: 0.728221, lon: -1.246671 }, //, 41.724°N, 71.429°W
    QQS: { name: "Shuttle Landing Facility (SLF)", link: "https://maps.app.goo.gl/5dKv3ZQxpu4BKbx7A?g_st=ac", lat: 0.499426, lon: -1.408385 }, //📷, 28.615°N, 80.6945°W
    RCA: { name: "Ellsworth Air Force Base", link: "https://www.ellsworth.af.mil/", lat: 0.770500, lon: -1.798993 }, //, 44°08′47″N, 103°04′29″W
    RDG: { name: "Reading Regional Airport", link: "https://readingairport.org/", lat: 0.704740, lon: -1.325844 }, //, 40°22′43″N, 075°57′55″W
    RDU: { name: "Raleigh–Durham International Airport", link: "https://www.rdu.com/", lat: 0.626185, lon: 1.375101 }, //🛫, 35°52′40″N, 078°47′15″
    RMG: { name: "Richard B. Russell Airport", link: "https://www.russellregionalairport.com/airport", lat: 0.599535, lon: -1.486298 }, //, 34°21′03″N, 085°09′31″W
    RMS: { name: "Ramstein Air Base", link: "https://www.ramstein.af.mil/", lat: 0.862837, lon: 0.132645 }, //, 49°26′13″N, 7°36′0″E
    RUH: { name: "King Khalid International Airport", link: "https://www.kkia.sa/en", lat: 0.435595, lon: 0.815049 }, //, 24°57′28″N, 046°41′56″E
    SKF: { name: "Joint Base San Antonio", link: "https://www.jbsa.mil/", lat: 0.513980, lon: -1.718257 }, //, 29°26′56″N, 098°26′56″W
    SKF_KF: { name: "Kelly Field", link: "https://www.jbsa.mil/", lat: 0.512836, lon: -1.720560 }, //, 29°23′00″N, 098°34′51″W
    SMQ: { name: "Somerset Airport", link: "https://www.somersetairport.com/", lat: 0.709059, lon: -1.303237 }, //, 40°37′34″N, 074°40′12″W
    SNN: { name: "Shannon Airport", link: "https://www.shannonairport.ie/", lat: 0.919822, lon: -0.155766 }, //, 52°42′07″N, 008°55′29″W
    SSH: { name: "Sharm El-Sheikh International Airport", link: "https://sharmelsheikh-airport.com/", lat: 0.488295, lon: 0.600301 }, //, 27°58′38″N, 34°23′41″E
    STL: { name: "St. Louis Lambert International Airport", link: "", lat: 0.676267, lon: -1.577104 }, //, 38°44′50″N, 090°21′41″W
    STN: { name: "London Stansted Airport", link: "https://www.stanstedairport.com/", lat: 0.905564, lon: 0.004102 }, //, 51°53′06″N, 0°14′06″E
    SUX: { name: "Sioux Gateway Airport", link: "https://www.sioux-city.org/163/Airport", lat: 0.740063, lon: -1.682226 }, //, 42°24′09″N, 096°23′04″W
    TCL: { name: "Tuscaloosa National Airport", link: "https://airport.tuscaloosa.com/", lat: 0.579808, lon: -1.529107 }, //, 33°13′14″N, 87°36′41″W
    TLV: { name: "Ben Gurion Airport", link: "https://www.iaa.gov.il/", lat: 0.558670, lon: 0.608819 }, //, 32°00′34″N, 034°52′58″E
    TYS: { name: "McGhee Tyson Airport", link: "https://flyknoxville.com/", lat: 0.625022, lon: -1.465970 }, //, 35°48′40″N, 083°59′38″W
    KTYS: { name: "McGhee Tyson Air National Guard Base", link: "https://www.134arw.ang.af.mil/", lat: 0.625022, lon: -1.465970 }, //, 35°48′40″N, 083°59′38″W
    VBT: { name: "Bentonville Municipal Airport", link: "https://www.bentonville.ar.gov/385/Airport", lat: 0.634354, lon: -1.644440 }, //🛫, 36°20′45″N, 094°13′10″W
    XJD: { name: "Al Udeid Air Base", link: "https://www.afcent.af.mil/Units/379th-Air-Expeditionary-Wing/", lat: 0.438402, lon: 0.895679 }, //, 25°07′07″N, 51°19′07″E
    YYC: { name: "Calgary International Airport", link: "https://www.yyc.com/", lat: 0.892106, lon: -1.990029 }, //, 51°06′50″N, 114°01′13″W
    ZDV: { name: "Davos Stilli Heliport", link: "https://www.davos-helicopter.com/?menuopen=3&showcontent=2", lat: 0.817027, lon: 0.171913 }, //, 46.8122°N, 9.8499°E
    ZRH: { name: "Zurich Airport", link: "https://www.flughafen-zuerich.ch/", lat: 0.828416, lon: 0.149211 }, //, 47°27′53″N, 008°32′57″E
    ZZZ: { name: "", link: "", lat: 0.0, lon: 0.0 } //,
    };
// @RalphHightower: remove the comma after the closing brace for the last airport record
