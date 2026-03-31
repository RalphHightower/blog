BEGIN {
    FS = "》"
    DEGREES = "°"  # °
    MINUTES ="′"   # '
    SECONDS = "″" # "
    # printf("#DEBUG000: SECONDS: %s\n", SECONDS)
    }

{
    if (NR > 1)
        printf(",\n")
    else
        printf("{\n")
    
    # printf("#DEBUG100: %d:%s\n", NR, $0)
    cntFields = split($0, fields)
    # printf("#DEBUG110: cntFields: %d\n", cntFields)
    if (cntFields == 2) {
        airport = fields[1]
        gps = fields[2]
        # printf("#DEBUG120: airport: %s, gps: %s\n", airport, gps)
        cntGPS = split(fields[2], gpsCoords, " ")
        # printf("#DEBUG130: cntGPS: %d\n", cntGPS)
        if (cntGPS == 2) {
            lat = gpsCoords[1]
            lon = gpsCoords[2]
            radLat = dmsToRadians(lat)
            radLon = dmsToRadians(lon)
            
            # printf("#DEBUG160: %s:%f %s:%f\n", lat, radLat, lon, radLon)
            output = jsonPrint(airport, radLat, radLon)
            printf("\t%s", output)
            }
        }
    }

END {
    printf("\n}\n")
    }

function dmsToRadians(dms, m, deg, min, sec, dec, dir, radians) {

    # Normalize whitespace (thin spaces, NBSP, etc.)
    gsub(/[[:space:]]+/, " ", dms)

    # Normalize quotes
    gsub(/′|‵|ʹ/, "′", dms)   # single primes
    gsub(/″|‶|ʺ/, "″", dms)   # double primes
    gsub(/["”]/, "″", dms)
    gsub(/['’]/, "′", dms)
    gsub(/″|‶|〞/, "″", dms)

    # Normalize all single-prime variants to U+2032
    gsub(/′|‵|ʹ|ˈ|`/, "′", dms)

# Normalize all double-prime variants to U+2033
    gsub(/″|‶|ʺ|˝|''/, "″", dms)

    gsub(/\u00A0|\u2009|\u202F/, " ", dms)
    gsub(/[[:space:]]+/, " ", dms)

    # printf("#DEBUG300: dms: %s\n", dms)

    # Case 1: decimal degrees (e.g., 40.701116°N)
    if (match(dms, /([0-9]+\.[0-9]+)° *([NSEW])/, m)) {
        dec = m[1] + 0.0
        dir = m[2] + 0.0
        # printf("#DEBUG310: dec: %f, dir: %s\n", dec, dir)
        }

    # Case 2: DMS with fractional seconds AND trailing direction
    else if (match(dms, /([0-9]+)°([0-9]+)['′]([0-9.]+)(["″]?)([NSEW])/, m)) {
        deg = m[1] + 0.0
        min = m[2] + 0.0
        sec = m[3] + 0.0
        dir = m[4]
        dec = deg + (min / 60.0) + (sec / 3600.0)
        # printf("#DEBUG320: deg: %f, min: %f, sec: %f, dir:%s\n", deg, min, sec, dir)
        }
    else {
        printf("**NO MATCH**\n")
        }

    # Apply sign
    if (dir ~ /[SW]/)
        dec = -dec

    # Convert to radians
    radians = dec * (3.141592653589793 / 180.0)

    return radians
    }

function jsonPrint(line, radLat, radLon, parts, name, iata, url, json) {
    match(line, /\[([^[]+?) \(([A-Z]{3})\)\]\((https?:\/\/[^)]+)\)/, parts)

    name = parts[1]
    iata = parts[2]
    url  = parts[3]

    json = sprintf("%s { name: \"%s\", link: \"%s\", lat: %f, lon: %f }", dms, iata, name, url, radLat, radLon)

    return json
    }

function codepoints(s, i, c) {
    printf("#CODEPOINTS:")
    for (i = 1; i <= length(s); i++) {
        c = substr(s, i, 1)
        printf(" U+%04X", sprintf("%d", c))
        }
    printf("\n")
    }
