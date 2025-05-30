---
layout: page
tags: [Location Predictor, Count Down, Count Up]
categories: [Donald Trump]
date: 2025-05-27 9:36 PM
#excerpt: ''
#image: 'BASEURL/assets/blog/img/.png'
#description:
#permalink:
title: "Where Is Trump? 🔥DC? FL⛳️?"
---


If it's the weekend, America's Golfer-in-Chief, [Trump](https://www.donaldjtrump.com/) is busy grifting America, playing golf at one of his golf courses. 

## Days Into / Terminal Count Down 

<div id="current-time"></div>

### Days of Hell

<div id="daysSince"></div>

### Computer, End Trump Presidency Simulation.[^2025]

<div id="daysRemaining"></div>

[^2025]: @RalphHightower: I'm wishing that the time between January 20, 2025 and January 20, 2029 is a just a nightmare Holodeck[^2029] simulation. 

[^2029]: [Begin Program: The Reality Of Building a Holodeck Today / Star Trek](https://www.startrek.com/news/begin-program-the-reality-of-building-a-holodeck-today)<br />Star Trek: The Next Generation<br />Published May 18, 2021<br />By Becca Caddy

## Where Is Trump?

<div id="golf">

<div id="golf-winter">

<h3> He’s Burning 🔥 Taxpayer Money 💰 Playing Golf 🏌️‍♂️ at His Winter Mar-a-Lago Resort ⛳️</h3>

<table>
    <thead>
        <tr>
            <th>Golfing ⛳️</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>Florida, Palm Beach</strong></td>
        </tr>
        <tr>
            <td><strong><a href="https://www.maralagoclub.com/">The Mar-a-Lago Club</a></strong><br /> 1100 South Ocean Boulevard, <br /> Palm Beach, Florida 33480 <br /> <a href="tel+15618322600">+1 (561) 832-2600</a></td>
        </tr>
    </tbody>
</table>

</div>

<div id="golf-summer">

<h3> He’s Burning 🔥 Taxpayer Money 💰 Playing Golf 🏌️‍♂️ at His Summer Golf Resort ⛳️ in Bedminster,  New Jersey</h3>

<table>
    <thead>
        <tr>
            <th>Golfing ⛳️</th>
        </tr>
    </thead>
   <tbody>
        <tr>
            <td><strong>New Jersey, Bedminster</strong></td>
        </tr>
        <tr>
            <td><strong><a href="https://www.trumpnationalbedminster.com/">Trump National Golf Club Bedminster</a></strong><br />900 Lamington Road <br /> Bedminster, NJ 07921 <br /> <a href="tel:+19084704400">+1 (908) 470-4400</a></td>
        </tr>
    </tbody>
</table>

</div>

</div>

<div id="burn">

<h3>Trump Is Busy Burning Federal Government to the Ground</h3>

<table>
    <thead>
        <tr>
            <th>Burning 🔥 Federal Government 💣</th>
        </tr>
    </thead>
   <tbody>
        <tr>
            <td><strong><a href="https://www.whitehouse.gov/">White House</a></strong></td>
        </tr>
        <tr>
            <td>1600 Pennsylvania Ave., NW <br /> Washington, DC 20500 <br /> <a href="tel:+12024561111">+1 (202) 456-1111</a> (comments) <br /> <a href="tel:+12024561414">+1 (202) 456-1414</a> (switchboard)</td>
        </tr>
    </tbody>
</table>

</div>

#### Check FAA NOTAM SECURITY/VIP

- [Federal Aviation Administration - Graphic TFRs](https://tfr.faa.gov/tfr3/?page=list)
- [JSON : Federal Aviation Administration - Graphic TFRs](https://tfr.faa.gov/tfr3/export/json)
- [XML : Federal Aviation Administration - Graphic TFRs](https://tfr.faa.gov/tfr3/export/xml)

#### Check His Public Schedule 

- [Roll Call Factba.se - Donald J. Trump's Public Schedule](https://rollcall.com/factbase/trump/topic/calendar/)
- [JSON : Roll Call Factba.se - Donald J. Trump's Public Schedule](https://media-cdn.factba.se/rss/json/trump/calendar-full.json)

<script>
// Set your dates here (year, month (0-based), day, hour, minute)
const startDate = new Date(2025, 0, 19, 0, 0);     // Jan 20, 2025 12:00 PM
const endDate = new Date(2029, 0, 20, 12, 0, 0);      // Jan 20, 2029, 12:00 PM

function getDaysDiff(from, to) {
    // Calculate difference in milliseconds
    const msPerDay = 24 * 60 * 60 * 1000;
    return Math.floor((to - from) / msPerDay);
    }

function fmtPercent(real) {
    const pct = Math.round(real * 10000) / 100;
    percent = pct.toFixed(2);
    return percent;
    }

function showElement(name) {
    const element = document.getElementById(name);
    if (element != null) {
        document.getElementById(name).style.display = 'block';
        }
    }

function hideElement(name) {
    var element = document.getElementById(name);
        if (element != null) {
        element.style.display = 'none';
        }
    }

function setElementText(element, text) {
    document.getElementById(element).textContent =  text;
    }

function updateCounters() {
    showElement('burn');
    showElement('golf');
    const now = new Date();
    setElementText('current-time', now.toString());
    // Set time to noon for today
    now.setHours(12, 0, 0, 0);
    const daysSince = getDaysDiff(startDate, now);
    const daysRemaining = getDaysDiff(now, endDate);
    const daysTotal = getDaysDiff(startDate, endDate);
    const pctTermCompleted = daysSince / daysTotal;
    const pctTermRemaing = daysRemaining / daysTotal;
    
    weekDay = now.getDay(); // Sunday = 0
    month = now.getMonth(); // January = 0
    monthDay = now.getDate(); // 1-31
    var burn = document.getElementById('burn');
    var golf = document.getElementById('golf');
    
    const holiday = isHoliday(now);
    if (holiday)
        weekDay = 7;
    switch (weekDay) {
        case 0:
        case 6:
        case 7: // out of bounds special: holiday
            showElement('golf');
            hideElement('burn');
            if (isMarALagoOpen(date)) {
                showElement('golf-winter');
                hideElement('golf-summer');
                }
            else {
                showElement('golf-summer');
                hideElement('golf-winter');
                }
            break;
        case 1:
        case 2:
        case 3:
        case 4:
            showElement('burn');
            hideElement('golf');
            break;
        case 5: // special case: check time
            if (now.getHour() > 16) {
                showElement('golf');
                hideElement('burn');
               }
            else {
                showElement('burn');
                hideElement('golf');
                }
            break;
        }

    setElementText('daysSince', "Days into term: " + (daysSince >= 0 ? daysSince + " days " + fmtPercent(pctTermCompleted) + "%" : "Event is in the future"));
    setElementText('daysRemaining', "Days remaining in term: " + (daysRemaining >= 0 ? daysRemaining + " days " + fmtPercent(pctTermRemaing) + "%" : "Event has passed"));
    }

    updateCounters();
    
function isHoliday(date) {
    retVal = floatingHoliday(date);
    if (! retVal)
        retVal = fixedHoliday(date);
    return (retVal);
    }

//floating holidays (shift to Friday or Monday if on weekend)
//1. New Year's Day (January 1)
//2. Juneteenth National Independence Day (June 19)
//3. Independence Day (July 4)
//4. Veterans Day (November 11)
//5. Christmas Day (December 25)
function floatingHoliday(param) { // 1

    const today = new Date(param);
    const monthDay = today.getDate(); // 1-31

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
            retVal = (dateMonth == 1 ? true : (dateMonth - shift) == 1 ? true : false);
            break;
        // June 19 (6/18, 6/20)
        case 6: // June
            retVal = (dateMonth == 19 ? true : (dateMonth - shift) == 19 ? true : false);
            break;
        // July 4 (7/3, 7/5)
        case 7: // July
            retVal = (dateMonth == 4 ? true : (dateMonth - shift) == 19 ? true : false);
            break;
        // November 11 (11/10, 11/12)
        case 11: // November
            retVal = (dateMonth == 11 ? true : (dateMonth - shift) == 19 ? true : false);
            break;
        // December 25 (12/24, 12/26, 12/31: NYD)
        case 12: // December
            retVal = (dateMonth == 25 ? true : (dateMonth - shift) == 19 ? true : false)
                || ((dateMonth == 31) && (shift == -1) ? true: false);
//            retVal = (dateMonth == 25 ? true : (dateMonth - shift) = 25) ?  || (dateMonth == 31) && (shift == -1) ? true : false);
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
                        retVal = ((15 <= dateMonth) && (dateMonth <= 21));
                        break;
                    // Memorial Day (Last Monday in May) [25-31]
                    case 5: // May
                        retVal = ((25 <= dateMonth) && (dateMonth <= 31));
                        break;
                    // Labor Day (First Monday in September) [01-07]
                    case 9: // September
                        retVal = ((1 <= dateMonth) && (dateMonth <= 7));
                        break;
                    // Columbus Day
                    case 10: // October (Second Monday in October) [08-14]
                        retVal = ((8 <= dateMonth) && (dateMonth <= 14));
                        break;
                        } // 4
            } //3
        } //2
    else if ((month == 11) && (weekDay == 4)) { //2
        // Thanksgiving (Fourth Thursday in November) [22-28]
        retVal = ((22 <= dateMonth) && (dateMonth <= 28));
        } //2
    return (retVal);
    } //1

function isMarALagoOpen(today) {
    dateToday = new Date(today);
    dateMothersDay = new Date(mothersDay(today));
    dateHalloween = new Date(dateToday.getFullYear(), 9, 31);
    return ((dateMothersDay <= dateToday) && (dateToday <= dateHalloween) ? false : true);
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

//                      01  02  03
// 04  05  06  07  08  09  10
// 11  12  13  14  15  16  17
// 18  19  20  21  22  23  24
// 25  26  27  28  29  30  31

//                           01  02
// 03  04  05  06  07  08  09
// 10  11  12  13  14  15  16
// 17  18  19  20  21  22  23
// 24  25  26  27  28  29  30
// 31

//                                01
// 02  03  04  05  06  07  08
// 09  10  11  12  13  14  15
// 16  17  18  19  20  21  22
// 23  24  25  26  27  28  29
// 30  31
// -->
</script>
