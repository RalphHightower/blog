---
layout: page
tags: [Location Predictor, Count Down, Count Up]
categories: [Donald Trump]
date: 2025-04-28 12:17 PM
#excerpt: ''
#image: 'BASEURL/assets/blog/img/.png'
#description:
#permalink:
title: "Where Is Trump? 🔥DC? FL⛳️?"
---

{% assign timestamp = 'now' | date: "%F %r%z %Z" %}
Current Date/Time: {{ timestamp }}

## Days Count Up / Term Count Down 

{% assign today_noon = 'now' | date: '%Y-%m-%d 12:00 PM' | date: '%s' %}
{% assign secs_inauguration2025 = '2025-01-20 12:00 PM' | date: '%s' | plus: 86400 %}
{% assign secs_inauguration2029 = '2029-01-20 12:00 PM' | date: '%s' %}

{% assign secs_total47 = secs_inauguration2029 | minus: secs_inauguration2025 %}
{% assign secs_since = today_noon | minus: secs_inauguration2025 %}
{% assign secs_remaining = inauguration2029 | minus: today_noon %}

DEBUG: secs_total47 {{ secs_total47 }}
DEBUG: secs_since {{ secs_since }}
DEBUG: secs_remaining {{ secs_remaining }}

{% assign days_total47 = secs_total47 | divided_by: 86400 %}
{% assign days_since = secs_since | divided_by: 86400 %}
{% assign days_remaining = secs_remaining | divided_by: 86400 %}

DEBUG: days_total47 {{ days_total47 }}
DEBUG: days_since {{ days_since }}
DEBUG: days_remaining {{ days_remaining }}

{% assign realsecs_total47 = secs_total47 | times: 1.0 %}
{% assign realsecs_since = secs_since | times: 1.0 %}
{% assign realsecs_remaining = secs_remaining | times: 1.0 %}

DEBUG: realsecs_total47 {{ realsecs_total47 }}
DEBUG: realsecs_since {{ realsecs_since }}
DEBUG: realsecs_remaining {{ realsecs_remaining }}

{% assign pctsecs_since = realdays_since | divided_by: realsecs_total47 | times: 100.0 | round | divided_by: 100.0 %}
{% assign pctsecs_remaining = realsecs_remaining | divided_by: realsecs_total47 | times: 100.0 | round | divided_by: 100.0 %}

DEBUG: pctsecs_since {{ pctsecs_since }}
DEBUG: pctsecs_remaining {{ pctsecs_remaining }}

{% assign realdays_total47 = days_total47 | times: 1.0 %}
{% assign realdays_since = days_since | times: 1.0 %}
{% assign realdays_remaining = days_remaining | times: 1.0 %}

DEBUG: realdays_total47: {{ realdays_total47 }}
DEBUG: realdays_since {{ realdays_since }}
DEBUG: realdays_remaining {{ realdays_remaining }}

{% assign pctdays_since = realdays_since | divided_by: realdays_total47 | times: 100.0 | round | divided_by: 100.0 %}
{% assign pctdays_remaining = realdays_remaining | divided_by: realdays_total47 | times: 100.0 | round | divided_by: 100.0 %}

DEBUG: pctdays_since {{ pctdays_since }}
DEBUG: pctdays_remaining {{ pctdays_remaining }}

### Days of Hell

Days since: {{ days_since }} Percent completed {{ pctdays_since }}

### Computer, End Trump Presidency Simulation.[^2025]

[^2025]: @RalphHightower: I'm wishing that the time between January 20, 2025 and January 20, 2029 is a just a nightmare Holodeck[^2029] simulation. 

[^2029]: [Begin Program: The Reality Of Building a Holodeck Today / Star Trek](https://www.startrek.com/news/begin-program-the-reality-of-building-a-holodeck-today)<br /> | times: How close is current technology to creating fully immersive photonic playgrounds?| times: <br />Star Trek: The Next Generation<br />Published May 18, 2021<br />By Becca Caddy

Days remaining: {{ days_remaining }} Percent remaining:{{ pctdays_remaining }}

## Where Is Trump?

{% assign today = 'now' %}
{% assign day = 'now' | date: '%A' %}
Today is {{ day }}.
{% case day %}
 {% when "Friday", "Saturday", "Sunday" %}
### He’s Burning 🔥 Taxpayer Money 💰 Playing Golf 🏌️‍♂️ at His Mar-a-Lago Resort ⛳️

| Golfing ⛳️ |
|---|
| | times: | times: [Mar-a-Lago](https://www.maralagoclub.com/)| times: | times: |
| [The Mar-a-Lago Club](https://www.maralagoclub.com/) <br /> 1100 South Ocean Boulevard, <br /> Palm Beach, Florida 33480 <br /> <a href="tel+15618322600">+1 (561) 832-2600</a> |
 {% else %}
### Trump Is Busy Burning Federal Government to the Ground

| Burning 🔥 Federal Government |
|---|
| | times: | times: [White House](https://www.whitehouse.gov)| times: | times: |
| 1600 Pennsylvania Ave., NW <br /> Washington, DC 20500 <br /> <a href="tel:+12024561111">+1 (202) 456-1111</a> (comments) <br /> <a href="tel:+12024561414">+1 (202) 456-1414</a> (switchboard) |
{% endcase %}

#### Check FAA NOTAM SECURITY/VIP

- [Federal Aviation Administration - Graphic TFRs](https://tfr.faa.gov/tfr3/?page=list)
- [JSON : Federal Aviation Administration - Graphic TFRs](https://tfr.faa.gov/tfr3/export/json)
- [XML : Federal Aviation Administration - Graphic TFRs](https://tfr.faa.gov/tfr3/export/xml)

#### Check His Public Schedule 

- [Roll Call Factba.se - Donald J. Trump's Public Schedule](https://rollcall.com/factbase/trump/topic/calendar/)
- [JSON : Roll Call Factba.se - Donald J. Trump's Public Schedule](https://media-cdn.factba.se/rss/json/trump/calendar-full.json)

{% comment %}
1461 days
Floating holidays (shift to Friday or Monday if on weekend):
1. New Year's Day (January 1)
2. Juneteenth National Independence Day (June 19)
3. Independence Day (July 4)
4. Veterans Day (November 11)
5. Christmas Day (December 25)

Fixed (fixed day of week):
1. Birthday of Martin Luther King, Jr. (Third Monday in January)
2. Washington's Birthday (Also known as Presidents Day; third Monday in February)
3. Memorial Day (Last Monday in May)
4. Labor Day (First Monday in September)
5. Columbus Day (Second Monday in October)
6. Thanksgiving Day (Fourth Thursday in November)

Static (remains fixed on date no matter what):
Logic: date '%Y' - 1 | modulus 4
1. Inauguration Day (January 20, every 4 years following a presidential election)

{% endcomment %}
