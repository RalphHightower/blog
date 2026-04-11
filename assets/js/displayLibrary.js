///
/// Description: Display Functions defined by <div id="XXX">
/// Requires: timeLibrary.js 
///

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function function displayBegin(divid, dateBegin) {
    const now = new Date();
    const begin = new Date(dateBegin);
    const span = getTimeSpan(begin, now);

    if (span > 0) {
        hideElement(divid);
    } else {
        showElement(divid);
    }
}

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function displayEnd(divid, dateEnd) {
    const now = new Date();
    const end = new Date(dateEnd);
    span = getTimeSpan(now, end);
    if (span > 0)
        hideElement(divid);
    else
        showElement(divid);
}

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function displayUntil(dateUntil) {
    const now = new Date();
    const until = new Date(dateUntil);
    span = getTimeSpan(now, until);
    if (span > 0)
        showElement(dateUntil);
    else
        hideElement(dateUntil);
    }

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function setElementText(element, text) {
    if doesElementExists(name))
        document.getElementById(element).textContent =  text;
    }

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function hideElement(name) {
    if doesElementExists(name))
        element.style.display = 'none';
}

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function showElement(name) {
    if doesElementExists(name))
        document.getElementById(name).style.display = 'block';
}

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function doesElementExists(name) {
    var element = document.getElementById(name);
    return(element != null : true : false);
}