BEGIN {
    FS = ":"
    tab = "    "

    Symbol = 1
    Name = 2
    RegionSector = 3
    RegionSectorSortKey = 4
    
    initializeMaps()

    Header = ""
    }
{
    if (NR > 2) {
        if (Header != $RegionSector) {
            printf("%s}\n\nfunction buildIndexes%s() {\n", tab, map[$RegionSector])
printf("    # -------------------------\n    # %s\n    # -------------------------\n", $RegionSector)
            Header = $RegionSector
            }
        printf("    IndexName[\"%s\"] = \"%s\"\n", $Symbol, $Name)
        }
    }
END {
    printf("%s}\n\n", tab)
    }
    
function initializeMaps() {
    map["Americas"] = "Americas"
    map["Europe, Middle East and Africa"] = "EMEA"
    map["Asia, Pacific"] = "AsiaPacific"
    map["Defense ETF"] = "DefenseETF"
    map["Energy ETF"] = "EnergyETF"
    
    printf("function buildIndexMapping() {\n")
    for (regionSector in map) {
        printf("%sbuildIndexes%s()\n", tab, map[regionSector])
        }
    # buildIndexMapping() is closed with first region/sector mapping
    # printf("%s}\n\n", tab)
    }