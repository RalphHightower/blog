///
/// Description: Formatting library 
/// Requires: timeLibrary.js 
///

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function fmtDaysRemaining(from, to) {
    const diff = getTimeSpan(from, to);
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    return days + " days";
}

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function fmtEasternToISO(dateString) {
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

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function fmtElapsed(ms) {
    const totalSeconds = Math.floor(ms / 1000);
    
    const days = Math.floor(totalSeconds / (24 * 3600));
    const remAfterDays = totalSeconds % (24 * 3600);
    
    const hours = Math.floor(remAfterDays / 3600);
    const remAfterHours = remAfterDays % 3600;
    
    const minutes = Math.floor(remAfterHours / 60);
    const seconds = remAfterHours % 60;
    
    const pad = n => String(n).padStart(2, '0');
    
    return `${days} day(s) / ${pad(hours)}:${pad(minutes)}:${pad(seconds)}`;
}

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function fmtHMS(label, time) {
    const dt = new Date(time);
    const tm = dt.toTimeString();
    const hhmmss = tm.substring(0, 8);
    const display = label + hhmmss;
    return display;
}

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function fmtHMSRemaining(from, to) {
    const diff = getTimeSpan(from, to);

    let totalSeconds = Math.floor(diff / 1000);
    let hours = Math.floor(totalSeconds / 3600);
    totalSeconds %= 3600;
    let minutes = Math.floor(totalSeconds / 60);
    let seconds = totalSeconds % 60;

    const hh = String(hours).padStart(2, "0");
    const mm = String(minutes).padStart(2, "0");
    const ss = String(seconds).padStart(2, "0");

    return hh + ":" + mm + ":" + ss;
}

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function fmtPercent(real) {
    const pct = Math.round(real * 10000) / 100;
    percent = pct.toFixed(2);
    return percent;
    }

