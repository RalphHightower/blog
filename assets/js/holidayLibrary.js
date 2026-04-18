//floating holidays (shift to Friday or Monday if on weekend)
//1. New Year's Day (January 1)
//2. Juneteenth National Independence Day (June 19)
//3. Independence Day (July 4)
//4. Veterans Day (November 11)
//5. Christmas Day (December 25)
function floatingHoliday(param) { // 1
    const today = new Date(param);

    shift = 0;
    day = today.getDay();
    switch (day) { //2
        case 0: // Sunday
            shift = 1;
            break;
        case 6: // Saturday
            shift = -1;
            break;
        } //2

    var retVal = false;

    floatDay = new Date(today);
    floatDay.setDate(today.getDate() + shift);
    const month = floatDay.getMonth() + 1; // January = 0
    const weekDay = floatDay.getDay(); // Sunday = 0
    const dateMonth = floatDay.getDate();
    switch (month) { //2
        // January 1 (12/31, 1/2)
        case 1: // January
            retVal = ((dateMonth - shift) == 1 ? true : false);
            break;
        // June 19 (6/18, 6/20)
        case 6: // June
            retVal = ((dateMonth - shift) == 19 ? true : false);
            break;
        // July 4 (7/3, 7/5)
        case 7: // July
            retVal = ((dateMonth - shift) == 4 ? true : false);
            break;
        // November 11 (11/10, 11/12)
        case 11: // November
            retVal = ((dateMonth - shift) == 11 ? true : false);
            break;
        // December 25 (12/24, 12/26, 12/31: NYD)
        case 12: // December
            retVal = ((dateMonth - shift) == 25 ? true : false)
                | ((dateMonth == 31) && (shift == -1) ? true: false);
            break;
        } //2
    return (retVal);
    } //1

//Fixed (fixed day of week)
//1. Birthday of Martin Luther King, Jr. (Third Monday in January) [15-21]
//2. Washington's Birthday (Also known as Presidents Day; third Monday in February) [15-21]
//3. Memorial Day (Last Monday in May) [25-31]
//4. Labor Day (First Monday in September) [01-07]
//5. Columbus Day (Second Monday in October) [08-14]
//6. Thanksgiving Day (Fourth Thursday in November) [22-28]
function fixedHoliday(param) { //1
    retVal = false;
    now = new Date(param);
    const month = now.getMonth() + 1;
    const weekDay = now.getDay(); // Sunday = 0
    const dateMonth = now.getDate();

    if (month != 11) { //2
        switch (weekDay) { //3
            case 1: // Monday
                switch (month) { //4
                    // Birthday of Martin Luther King, Jr. (Third Monday in January) [15-21]
                    case 1: // January
                        // Washington's Birthday (Also known as Presidents Day; third Monday in February) [15-21]
                    case 2: // February
                        retVal = (isBetween(dateMonth, 15, 21));
                    break;
                // Memorial Day (Last Monday in May) [25-31]
                case 5: // May
                    retVal = (isBetween(dateMonth, 25, 31));
                    break;
                // Labor Day (First Monday in September) [01-07]
                case 9: // September
                    retVal = (isBetween(dateMonth, 1, 7));
                    break;
                case 10: // October (Second Monday in October) [08-14]
                // Columbus Day
                    retVal = (isBetween(dateMonth, 8, 14));
                    break;
                    } // 4
            } //3
        } //2
    else if ((month == 11) && (weekDay == 4)) { //2
        // Thanksgiving (Fourth Thursday in November) [22-28]
        retVal = (isBetween(dateMonth, 22, 28));
        } //2
    return (retVal);
    } //1

function isHoliday(date) {
    retVal = floatingHoliday(date);
    if (! retVal)
        retVal = fixedHoliday(date);
    return (retVal);
    }

function isBetween(val, from, to) {
    return ((from <= val) && (val <= to) ? true : false);
    }

function mothersDay(param) {
    date = new Date(param);
    year = date.getFullYear();
    mayDay = new Date(year, 4, 1);
    weekDay = mayDay.getDay();
//May begins : Second Sunday 
//1:14
//2:13
//3:12
//4:11
//5:10
//6:9
//0:8
    secondSunday = (15 - (weekDay > 0 ? weekDay : 7));
    dateMotherDay = new Date(year, 4, secondSunday);
    return(dateMotherDay);
    }

// <!--
// 01  02  03  04  05  06  07
// 08  09  10  11  12  13  14
// 15  16  17  18  19  20  21
// 22  23  24  25  26  27  28
// 29  30  31

//      01  02  03  04  05  06
// 07  08  09  10  11  12  13
// 14  15  16  17  18  19  20
// 21  22  23  24  25  26  27
// 28  29  30  31

//            01  02  03  04  05
// 06  07  08  09  10  11  12
// 13  14  15  16  17  18  19
// 20  21  22  23  24  25  26
// 27  28  29  30  31

//                 01  02  03  04
// 05  06  07  08  09  10  11
// 12  13  14  15  16  17  18
// 19  20  21  22  23  24  25
// 26  27  28  29  30  31

//                       01  02  03
// 04  05  06  07  08  09  10
// 11  12  13  14  15  16  17
// 18  19  20  21  22  23  24
// 25  26  27  28  29  30  31

//                            01  02
// 03  04  05  06  07  08  09
// 10  11  12  13  14  15  16
// 17  18  19  20  21  22  23
// 24  25  26  27  28  29  30
// 31

//                                 01
// 02  03  04  05  06  07  08
// 09  10  11  12  13  14  15
// 16  17  18  19  20  21  22
// 23  24  25  26  27  28  29
// 30  31
// -->
