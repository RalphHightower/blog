#!/usr/bin/awk -f

BEGIN {
    PI = atan2(0, -1)
    FS = ","
    }

# Parse ANY DMS or decimal format
function parse_coord(str, obj,    d,m,s,hem,arr) {

    gsub(" ", "", str)
    # Hemisphere
    match(str, /([NSEW])/, arr)
    hem = arr[1]

    # Strip hemisphere
    gsub(/[NSEW]/, "", str)

    # Case 4: Full DMS (with or without decimal seconds)
    if ((status = match(str, /^([0-9]+)°([0-9]+)[′']([0-9]+(\.[0-9]+)?)["″]?$/, arr))) {
        # printf("#DEBUG140: status: %d\n", status)
        d = arr[1] * 1.0
        m = arr[2] * 1.0
        s = arr[3] * 1.0
        obj["deg"] = d + m/60.0 + s/3600.0
        obj["hem"] = hem
        return
    }

    # Case 3: Degrees + minutes: 9°50′
    if (status = match(str, /^([0-9]+)°([0-9]+)[′']$/, arr)) {
        # printf("#DEBUG130: status: %d\n", status)
        d = arr[1] * 1.0
        m = arr[2] * 1.0
        obj["deg"] = d + m/60.0
        obj["hem"] = hem
        return
    }

    # Case 1: Decimal degrees like 40.701116°
    if (status = match(str, /^([0-9]+\.[0-9]+)°?$/, arr)) {
        # printf("#DEBUG110: status: %d\n", status)
        obj["deg"] = arr[1] * 1.0
        obj["hem"] = hem
        return
    }

    # Case 2: Degrees only: 46° or 46°
    if (status = match(str, /^([0-9]+)°?$/, arr)) {
        # printf("#DEBUG120: status: %d\n", status)
        obj["deg"] = arr[1] * 1.0
        obj["hem"] = hem
        return
    }

}

function to_radians(obj,    deg) {
    deg = obj["deg"]
    if (obj["hem"] == "S" || obj["hem"] == "W")
        deg = -deg
    return deg * (PI / 180.0)
}

function dms_to_deg(a,    deg) {
    deg = a["d"] + a["m"]/60.0 + a["s"]/3600.0
    if (a["hem"] == "S" || a["hem"] == "W")
        deg = -deg
    return deg
    }

function deg_to_rad(x) {
    return x * (PI / 180.0)
    }

{
    # DMS fields are the last two fields thanks to your comma trick
    if (NF >= 6) {
        lat_dms = $(NF-1)
        lon_dms = $(NF)
    
        parse_coord(lat_dms, lat)
        parse_coord(lon_dms, lon)

        #printf("%.6f %.6f\n", to_radians(lat), to_radians(lon))
    
        out = ""
        for (ndx = 1; ndx < NF; ndx ++) {
            if (substr($ndx, 1, 5) == " lat:") {
                p_lat = sprintf("lat: %.6f,", to_radians(lat))
                printf(" lat: %f, ", to_radians(lat))
                }
            else if (substr($ndx, 1, 5) == " lon:") {
                p_lon = sprintf("lon: %.6f ", to_radians(lon))
                printf("lon: %f },", to_radians(lon))
                }
            else {
                printf("%s,", $ndx)
                }
            }
        printf("%s\n", $NF)
        }
    else
        printf("%s\n", $0)
    }

END {
    printf("\t// @RalphHightower: remove the comma after the closing brace for the last airport record\n")
    }
