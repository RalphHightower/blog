---
layout: page
tags: []
categories: [RalphHightower]
date: 2025-04-24 11:07 PM
#excerpt: ''
#image: 'BASEURL/assets/blog/img/.png'
#description:
#permalink:
title: "Test Holidays"
---

{% liquid

assign timestamp = 'now'
assign year = timestamp | date: '%Y'
assign month = timestamp | date: '%b'
assign day = timestamp | date: '%d"
assign weekDay = timestamp | date: '%a'
assign timezone = timestamp | date: 'v%z"

assign holiday = false

assign shift = 0
case day
    when "Sat"
        shift = -86000
    when "Sun"
        shift = 86000
    endcase

case month
    when "Jan"
        if (day == "01")
            holiday = true
        else
            if (weekDay == "Mon")
                possible = "15.16.17.18.19.20.21."
                if (possible contains day)
                    holiday = true
                    endif
            endif

    when "Feb"
        if (weekDay == "Mon")
            possible = "15.16.17.18.19.20.21."
            if (possible contains day)
                holiday = true
                endif
            endif

    when "May"
        if (weekDay == "Mon")
            possible = "25.26.27.28.29.3031."
            if (possible contains day)
                holiday = true
                endif
            endif

    when "Jun"
        if (day == "19")
            holiday = true
            endif

    when "Jul"
        if (day == "04"
            holiday = true
            endif

    when "Sep"
        if (weekDay == "Mon")
            possible = "01.02.03.04.05.06.07."
            if (possible contains day)
                holiday = true
                endif
            endif

    when "Oct"
        if (weekDay == "Mon")
            possible = "08.09.10.11.12.13.14."
            if (possible contains day)
                holiday = true
                endif
            endif

    when "Nov"
        if (weekDay == "Thu")
            possible = "22.23.24.25.26.27.28."
            if (possible contains day)
                holiday = true
                endif
            endif

    when "Dec"
        if (day == "25")
            holiday = true
            endif

    endcase
    
if (holiday == "true")

%}

{% comment %}
Floating holidays (shift to Friday or Monday if on weekend):
1. New Year's Day (January 1)
2. Juneteenth National Independence Day (June 19)
3. Independence Day (July 4)
4. Veterans Day (November 11)
5. Christmas Day (December 25)

Fixed (fixed day of week):
1. Birthday of Martin Luther King, Jr. (Third Monday in January) [15-21]
2. Washington's Birthday (Also known as Presidents Day; third Monday in February) [15-21]
3. Memorial Day (Last Monday in May) [25-31]
4. Labor Day (First Monday in September) [01-07]
5. Columbus Day (Second Monday in October) [08-14]
6. Thanksgiving Day (Fourth Thursday in November) [22-28]

 01  02  03  04  05  06  07
 08  09  10  11  12  13  14
 15  16  17  18  19  20  21
 22  23  24  25  26  27  28
 29  30  31

      01  02  03  04  05  06
 07  08  09  10  11  12  13
 14  15  16  17  18  19  20
 21  22  23  24  25  26  27
 28  29  30  31

            01  02  03  04  05
 06  07  08  09  10  11  12
 13  14  15  16  17  18  19
 20  21  22  23  24  25  26
 27  28  29  30  31

                 01  02  03  04
 05  06  07  08  09  10  11
 12  13  14  15  16  17  18
 19  20  21  22  23  24  25
 26  27  28  29  30  31

                      01  02  03
 04  05  06  07  08  09  10
 11  12  13  14  15  16  17
 18  19  20  21  22  23  24
 25  26  27  28  29  30  31


                           01  02
 03  04  05  06  07  08  09
 10  11  12  13  14  15  16
 17  18  19  20  21  22  23
 24  25  26  27  28  29  30
 31

                                01
 02  03  04  05  06  07  08
 09  10  11  12  13  14  15
 16  17  18  19  20  21  22
 23  24  25  26  27  28  29
 30  31

Static (remains fixed on date no matter what):
Logic: date '%Y' - 1 | modulus 4
1. Inauguration Day (January 20, every 4 years following a presidential election)

{% endcomment %}
    