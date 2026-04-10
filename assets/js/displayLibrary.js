function displayBegin(divid, dateBegin) {
    const now = new Date();
    const begin = new Date(dateBegin);
    const span = getTimeSpan(begin, now);

    if (span > 0) {
        hideElement(divid);
    } else {
        showElement(divid);
    }
}

function displayEnd(divid, dateEnd) {
    const now = new Date();
    const end = new Date(dateEnd);
    span = getTimeSpan(now, end);
    if (span > 0)
        hideElement(divid);
    else
        showElement(divid);
    }

function displayUntil(dateUntil) {
    const now = new Date();
    const until = new Date(dateUntil);
    span = getTimeSpan(now, until);
    if (span > 0)
        showElement(dateUntil);
    else
        hideElement(dateUntil);
    }

function getTimeSpan(from, to) {
    return(to - from);
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

