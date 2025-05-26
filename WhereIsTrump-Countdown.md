---
layout: page
tags: [Location Predictor, Count Down, Count Up]
categories: [Donald Trump]
date: 2025-04-30 8:20 AM
#excerpt: ''
#image: 'BASEURL/assets/blog/img/.png'
#description:
#permalink:
title: "Where Is Trump? 🔥DC? FL⛳️?"
---

If it's the weekend, America's Golfer-in-Chief, [Trump](https://www.donaldjtrump.com/) is busy grifting America, playing golf at his [Mar-a-Lago Golf Resort](https://www.maralagoclub.com/)

## Days Into / Terminal Count Down 

### Days of Hell

  <div id="daysSince"></div>

### Computer, End Trump Presidency Simulation.[^2025]

  <div id="daysRemaining"></div>

[^2025]: @RalphHightower: I'm wishing that the time between January 20, 2025 and January 20, 2029 is a just a nightmare Holodeck[^2029] simulation. 

[^2029]: [Begin Program: The Reality Of Building a Holodeck Today / Star Trek](https://www.startrek.com/news/begin-program-the-reality-of-building-a-holodeck-today)<br />Star Trek: The Next Generation<br />Published May 18, 2021<br />By Becca Caddy

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

    function updateCounters() {
      showElement('burn');
      showElement('golf');
      const now = new Date();
      // Set time to noon for today
      now.setHours(12, 0, 0, 0);

      const daysSince = getDaysDiff(startDate, now);
      const daysRemaining = getDaysDiff(now, endDate);
      const daysTotal = getDaysDiff(startDate, endDate);
      const pctTermCompleted = daysSince / daysTotal;
      const pctTermRemaing = daysRemaining / daysTotal;
  
      weekDay = now.getDay(); // Sunday = 0
      //weekDay = 0;
      month = now.getMonth(); // January = 0
      monthDay = now.getDate(); // 1-31
      var burn = document.getElementById('burn');
      var golf = document.getElementById('golf');
      switch (weekDay) {
        case 0:
        case 6:
        case 7: // out of bounds special: holiday
          //document.getElementById('burn').style.display = 'none';
          //document.getElementById('golf').style.display = 'block';
          showElement('golf');
          hideElement('burn');
          break;
        case 1:
        case 2:
        case 3:
        case 4:
          //document.getElementById('burn').style.display = 'block';
          //document.getElementById('golf').style.display = 'none';
          showElement('burn');
          hideElement('golf');
          break;
        case 5: // special case: check time
          break;
        }


      document.getElementById('daysSince').textContent = daysSince >= 0 ? daysSince + " days " + fmtPercent(pctTermCompleted) + "%" : "Event is in the future";
      document.getElementById('daysRemaining').textContent = daysRemaining >= 0 ? daysRemaining + " days " + fmtPercent(pctTermRemaing) + "%" : "Event has passed";
    }

    updateCounters();
  </script>

## Where Is Trump?

<div id="golf">

### He’s Burning 🔥 Taxpayer Money 💰 Playing Golf 🏌️‍♂️ at His Mar-a-Lago Resort ⛳️

<table>
  <tr>
    <th>Golfing ⛳️</th>
  </tr>
  <tr>
    <td><strong><a href="https://www.maralagoclub.com/">Mar-a-Lago</a></strong></td>
  </tr>
  <tr>
    <td><a href="https://www.maralagoclub.com/">The Mar-a-Lago Club<br /> 1100 South Ocean Boulevard, <br /> Palm Beach, Florida 33480 <br /> <a href="tel+15618322600">+1 (561) 832-2600</a></a></td>
  </tr>
</table>

</div>

<div id="burn">

### Trump Is Busy Burning Federal Government to the Ground

<table>
  <tr>
    <th>Burning 🔥 Federal Government</th>
  </tr>
  <tr>
    <td><strong><a href="https://www.whitehouse.gov">White House</a><strong></td>
  </tr>
  <tr>
    <td>1600 Pennsylvania Ave., NW <br /> Washington, DC 20500 <br /> <a href="tel:+12024561111">+1 (202) 456-1111</a> (comments) <br /> <a href="tel:+12024561414">+1 (202) 456-1414</a> (switchboard)</td>
  </tr>
</table>

</div>

#### Check FAA NOTAM SECURITY/VIP

- [Federal Aviation Administration - Graphic TFRs](https://tfr.faa.gov/tfr3/?page=list)
- [JSON : Federal Aviation Administration - Graphic TFRs](https://tfr.faa.gov/tfr3/export/json)
- [XML : Federal Aviation Administration - Graphic TFRs](https://tfr.faa.gov/tfr3/export/xml)

#### Check His Public Schedule 

- [Roll Call Factba.se - Donald J. Trump's Public Schedule](https://rollcall.com/factbase/trump/topic/calendar/)
- [JSON : Roll Call Factba.se - Donald J. Trump's Public Schedule](https://media-cdn.factba.se/rss/json/trump/calendar-full.json)