///
/// Description: Trump specific Javascript functions 
/// Requires: displayLibrary.js, holidayLibrary.js 
///

/// <summary>
/// trumpGPS: Displays where Trump is based on the week days and weekend 
/// </summary>
/// <param name="date"></param>
/// <returns>none</returns>
/// DOM:
/// <div id="burn">Div section to show or hide White House</div>
/// <div id="golf">Div section for Trump’s summer/winter golf homes</div>
function trumpGPS(date) {
    now = new Date(date)
    weekDay = now.getDay(); // Sunday = 0

    const holiday = isHoliday(now);
    if (holiday)
        weekDay = 7;
    switch (weekDay) {
        case 0:
        case 6:
        case 7: // out of bounds special: holiday
            showElement('golf');
            hideElement('burn');
            whichGolfHome(date);
            break;
        case 1:
        case 2:
        case 3:
        case 4:
            showElement('burn');
            hideElement('golf');
            break;
        case 5: // special case: check time
            // Assume Trump checks out of the Oval Office at 3 PM
            if (now.getHours() > 15) {
                showElement('golf');
                hideElement('burn');
                whichGolfHome(date);
               }
            else {
                showElement('burn');
                hideElement('golf');
                }
            break;
        }
    }

/// <summary>
/// </summary>
/// <param name=""></param>
/// DOM:
/// <div id="burn">Div section to show or hide White House</div>
/// <div id="golf">Div section for Trump’s summer/winter golf homes</div>
/// <div id="golf-summer">Div section for Trump’s summer golf home, Bedminster NJ</div>
/// <div id="golf-winter">Div section for Trump’s winter golf home, Mar-a-Lago</div>
function whichGolfHome(date) {
    showElement("golf");
    hideElement("burn");
    if (isMarALagoOpen(date)) {
        showElement('golf-winter');
        hideElement('golf-summer');
        }
    else {
        showElement('golf-summer');
        hideElement('golf-winter');
        }
    }

/// <summary>
/// </summary>
/// <param name="date">Checks if date is in Mar-a-Lago's season</param>
/// <returns>False, if date is between Mother's Day and Halloween. True, if otherwise. </returns>
function isMarALagoOpen(today) {
    dateToday = new Date(today);
    dateMothersDay = new Date(mothersDay(today));
    dateHalloween = new Date(dateToday.getFullYear(), 9, 31);

    return (isBetween(dateToday, dateMothersDay, dateHalloween) ? false : true);
    }

