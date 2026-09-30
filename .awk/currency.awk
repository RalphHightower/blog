{ printf("%s\n\n%s\n", $0, "$" formatCurrency($0)) }

function formatCurrency(amount) {
    printf("#DEBUG110; amount: %s\n", amount)
    retVal = amount
    cnt = split(amount, money, ".")
    if (cnt == 2) {
        dollars = money[1]
        cents = sprintf("%03f", money[2])
        len = length(dollars)
        commas = len / 3 - 1
        printf("#DEBUG120: cnt: %d, dollars: %s, cents: %s, len: %d, commas: %d\n", cnt, dollars, cents, len, commas)
        if (commas > 0) {
            retVal = ""
            #0000000
            #000000
            #00000
            #0000
            retVal = ""
            comma = 3
            for (ndx = len; ndx > 0; ndx --) {
                retVal = substr(dollars, ndx, 1) retVal
                comma --
                #printf("#DEBUG120: ndx: %d, comma: %s, retVal: %s\n", ndx, comma, retVal)
                if ((comma == 0) && (ndx > 1)){
                    retVal = "," retVal
                    comma = 3
                    }
                }
            retVal = retVal "." cents
            }
        else
            retVal = dollars "." cents
        }
    printf("#DEBUG: retVat: %s\n", retVal)
    return(retVal)
    }
