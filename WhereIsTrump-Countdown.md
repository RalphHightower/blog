---
layout: page
tags: [Location Predictor, Count Down, Count Up]
categories: [Donald Trump]
date: 2025-04-23 11:30 AM
#excerpt: ''
#image: 'BASEURL/assets/blog/img/.png'
#description:
#permalink:
title: "Where Is Trump? 🔥DC? FL⛳️?"
---

## Days Count Up / Term Count Down 

### Days of Hell

{% assign past_date = '2025-01-20 12:00 PM' | date: '%s' %}
{% assign today_noon = 'now' | date: '%Y-%m-%d 12:00 PM' | date: '%s' %}
{% assign difference_in_seconds = today_noon | minus: past_date %}
{% assign days_since = difference_in_seconds | divided_by: 86400 %}
Days since: {{ days_since }}

### Computer, End Trump Presidency Simulation. 

{% assign future_date = '2029-01-20 12:00 PM' | date: '%s' %}
{% assign today_noon = 'now' | date: '%Y-%m-%d 12:00 PM' | date: '%s' %}
{% assign difference_in_seconds = future_date | minus: today_noon %}
{% assign days_remaining = difference_in_seconds | divided_by: 86400 %}
Days remaining: {{ days_remaining }}

## Where Is Trump?

{% assign today = 'now' %}
{% assign day = 'now' | date: '%a' %}
{{ Today: day }}
{% case day %}
    {% when "Fri", "Sat", "Sun" %}
### He’s Burning 🔥 Taxpayer Money 💰 Playing Golf 🏌️‍♂️ at His Mar-a-Lago Resort ⛳️

| Golfing ⛳️ |
|---|
| **[Mar-a-Lago](https://www.maralagoclub.com/)** |
| [The Mar-a-Lago Club](https://www.maralagoclub.com/) <br /> 1100 South Ocean Boulevard, <br /> Palm Beach, Florida 33480 <br /> <a href="tel+15618322600">+1 (561) 832-2600</a> |
    {% else %}
### Trump Is Busy Burning Federal Government to the Ground

| Burning 🔥 Federal Government |
|---|
| **[White House](https://www.whitehouse.gov)** |
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

Floating holidays (shift to Friday or Monday if on weekend):
1. New Year's Day (January 1)
2. Juneteenth National Independence Day (June 19)
3. Independence Day (July 4)
4. Veterans Day (November 11)
5. Christmas Day (December 25)

Fixed (fixed day of week):
1. Birthday of Martin Luther King, Jr. (Third Monday in January)
2. Inauguration Day (January 20, every 4 years following a presidential election)
3. Washington's Birthday (Also known as Presidents Day; third Monday in February)
4. Memorial Day (Last Monday in May)
5. Labor Day (First Monday in September)
6. Columbus Day (Second Monday in October)
7. Thanksgiving Day (Fourth Thursday in November)

{% endcomment %}

#### Errors 

- [ ] Liquid Warning: Liquid syntax error (line 7): Expected end_of_string but found string in "{{current_date | date '%s' }}" in WhereIsTrump-Countdown.md
- [ ] Liquid Warning: Liquid syntax error (line 16): Expected end_of_string but found string in "{{current_date | date '%s' }}" in WhereIsTrump-Countdown.md
- [ ] Liquid Warning: Liquid syntax error (line 24): [:pipe, "|"] is not a valid expression in "{{| today | date: '%a' }}" in WhereIsTrump-Countdown.md
- [ ] Liquid Warning: Liquid syntax error (line 25): Expected end_of_string but found colon in "{{ Today: day }}" in WhereIsTrump-Countdown.md
- [ ] Liquid Warning: Liquid syntax error (line 74): Unexpected character { in "{{'now' | date: '%Y-%m-%d 12:00 PM' {% assign noon = current_date | date '%s' }}" in WhereIsTrump-Countdown.md
- [ ] Liquid Warning: Liquid syntax error (line 75): Unexpected character { in "{{'now' | date: '%Y-%m-%d 12:00 PM' {% assign noon = current_date | date '%s' }}" in WhereIsTrump-Countdown.md
- [ ] Liquid Warning: Liquid syntax error (line 76): [:pipe, "|"] is not a valid expression in "{{| today | date: '%a' }}" in WhereIsTrump-Countdown.md
- [ ] Liquid Warning: Liquid syntax error (line 77): Expected end_of_string but found colon in "{{ Today: day }}" in WhereIsTrump-Countdown.md
