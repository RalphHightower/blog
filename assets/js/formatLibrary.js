function fmtDaysRemaining(from, to) {
    const diff = getTimeSpan(from, to);
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    return days + " days";
}

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

function fmtPercent(real) {
    const pct = Math.round(real * 10000) / 100;
    percent = pct.toFixed(2);
    return percent;
    }

function fmtHMS(label, time) {
    const dt = new Date(time);
    const tm = dt.toTimeString();
    const hhmmss = tm.substring(0, 8);
    const display = label + hhmmss;
    return display;
}

