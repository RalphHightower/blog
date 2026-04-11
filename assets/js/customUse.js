///
/// <title>Custom Javascript functions for page<title>
/// <dependency>
/// displayLibrary.js 
/// timeLibrary.js 
/// </dependency>
///

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
		
<!-- No Kings 2026-03-28T20:00:00Z -->
displayUntil("2026-03-28T20:00:00Z");

<!-- No Kings 2026-05-01T20:00:00Z -->
displayUntil("2026-05-01T20:00:00Z");

<!-- Bruce Springsteen Land of Hope and Dreams 2026-05-24T23:59:59Z -->
displayUntil("2026-05-24T23:59:59Z");

<!-- Primary Election 2026-06-09T11:00:00Z – 2026-06-09T23:00:00Z -->
displayUntil("2026-06-09T23:00:00Z");
displayBegin("primary-open", "2026-11-03T12:00:00Z");
displayBegin("primary-close", "2026-06-09T11:00:00Z");
displayEnd("primary-close", "2026-06-09T23:00:00Z");

<!-- Farm Aid 2026-09-30T23:59:59Z -->
displayUntil("2026-09-30T23:59:59Z");

<!-- Mid-Term Election Tuesday, November 3, 2026 at 12:00:00 – Wednesday, November 4, 2026 at 00:00:00 timeanddate.com GMT -->
displayUntil("2026-11-04T00:00:00Z");
displayBegin("midterm-open", "2026-11-03T12:00:00Z");
displayBegin("midterm-close", "2026-11-04T00:00:00Z");
displayEnd("midterm-close", "2026-11-04T00:00:00Z");

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function iranWar2026(divID) {
    const now = new Date();
    timeSpan = getTimeSpan(warStart, now);
    fmtWarElapsed = fmtElapsed(timeSpan);
    setElementText(divID, fmtWarElapsed);
    }

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function updateDateCounters() {
    const now = Date.now();

    updateDateCounter("primary-open",  "2026-06-09T11:00:00Z", "days");
    updateDateCounter("primary-close", "2026-06-09T23:00:00Z", "hms");

    updateDateCounter("midterm-open",  "2026-11-03T12:00:00Z", "days");
    updateDateCounter("midterm-close", "2026-11-04T00:00:00Z", "hms");
    }

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function updateDateCounter(id, targetTime, mode) {
    if (doesElementExists(id)) {

        const now = Date.now();
        const to  = new Date(targetTime).getTime();
    
        const diff = getTimeSpan(now, to);
    
        if (diff < 0) {
            setElement(id, "");
            hideElement(id);
            return;
        }
    
        switch(id) {
            case "primary-open":
                desc = "Primary opens in " ;
                break;
            case "primary-close":
                desc = "Primary closes in " ;
                break;
            case "midterm-open":
                desc = "Midterm election opens in " ;
                break;
            case "midterm-close":
                desc = "Midterm closes in " ;
                break;
            }
    
        if (mode === "days") {
            setElement(id, desc + fmtDaysRemaining(now, to));
        } else if (mode === "hms") {
            setElement(id, desc + fmtHMSRemaining(now, to));
        }
        showElement(id)
    }
}

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function updateCounters() {
    updateDateCounters();
    
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

    setElementText('daysSince', "Days into term: " + (daysSince >= 0 ? daysSince + " days " + fmtPercent(pctTermCompleted) + "%" : "Event is in the future"));
    setElementText('daysRemaining', "Days remaining in term: " + (daysRemaining >= 0 ? daysRemaining + " days " + fmtPercent(pctTermRemaing) + "%" : "Event has passed"));
    iranWar2026('iranWar');
    }

