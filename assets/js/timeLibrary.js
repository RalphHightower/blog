function fmtDaysRemaining(from, to) {
    const diff = getTimeSpan(from, to);
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    return days + " days";
}

function updateCountdown(id, targetTime, mode) {
    const el = document.getElementById(id);
    if (!el) return;

    const now = Date.now();
    const to  = new Date(targetTime).getTime();

    const diff = getTimeSpan(now, to);

    if (diff < 0) {
        el.textContent = "";
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
        el.textContent = desc + fmtDaysRemaining(now, to);
    } else if (mode === "hms") {
        el.textContent = desc + fmtHMSRemaining(now, to);
    }
    showElement(id)
}

function getDaysDiff(from, to) {
    // Calculate difference in milliseconds
    const msPerDay = 24 * 60 * 60 * 1000;
    return Math.floor((to - from) / msPerDay);
    }

function easternToISO(dateString) {
  // Interpret the input as a local date/time in America/New_York
  const dt = new Date(
    new Date(dateString).toLocaleString("en-US", {
      timeZone: "America/New_York"
    })
  );

  // Extract the actual Eastern offset for that moment
  const offsetMinutes = -(
    new Date(dt.toLocaleString("en-US", { timeZone: "UTC" })) - dt
  ) / 60000;

  const sign = offsetMinutes <= 0 ? "-" : "+";
  const pad = n => String(Math.abs(n)).padStart(2, "0");
  const offset =
    sign +
    pad(Math.floor(Math.abs(offsetMinutes) / 60)) +
    ":" +
    pad(Math.abs(offsetMinutes) % 60);

  // Build ISO‑8601 string with the correct offset
  return (
    dt.getFullYear() +
    "-" +
    pad(dt.getMonth() + 1) +
    "-" +
    pad(dt.getDate()) +
    "T" +
    pad(dt.getHours()) +
    ":" +
    pad(dt.getMinutes()) +
    ":" +
    pad(dt.getSeconds()) +
    offset
  );
}

function getDaysDiff(from, to) {
    // Calculate difference in milliseconds
    const msPerDay = 24 * 60 * 60 * 1000;
    return Math.floor((to - from) / msPerDay);
    }

function easternToISO(dateString) {
  // Interpret the input as a local date/time in America/New_York
  const dt = new Date(
    new Date(dateString).toLocaleString("en-US", {
      timeZone: "America/New_York"
    })
  );

  // Extract the actual Eastern offset for that moment
  const offsetMinutes = -(
    new Date(dt.toLocaleString("en-US", { timeZone: "UTC" })) - dt
  ) / 60000;

  const sign = offsetMinutes <= 0 ? "-" : "+";
  const pad = n => String(Math.abs(n)).padStart(2, "0");
  const offset =
    sign +
    pad(Math.floor(Math.abs(offsetMinutes) / 60)) +
    ":" +
    pad(Math.abs(offsetMinutes) % 60);

  // Build ISO‑8601 string with the correct offset
  return (
    dt.getFullYear() +
    "-" +
    pad(dt.getMonth() + 1) +
    "-" +
    pad(dt.getDate()) +
    "T" +
    pad(dt.getHours()) +
    ":" +
    pad(dt.getMinutes()) +
    ":" +
    pad(dt.getSeconds()) +
    offset
  );
}

