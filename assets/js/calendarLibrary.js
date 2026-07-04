/* ============================================
   Unified Civil-Time Framework
   America/New_York DST-Aware
   ============================================ */

function toNY(d) {
  return new Date(
    d.toLocaleString("en-US", { timeZone: "America/New_York" })
  );
}

function nyAnchor(year, month, day, hour, minute = 0, second = 0) {
  return toNY(new Date(year, month - 1, day, hour, minute, second));
}

function nowNY() {
  return toNY(new Date());
}

function dayDiff(start, end) {
  return Math.floor((end - start) / 86400000);
}

function percent(part, whole) {
  return (part / whole) * 100;
}

function makeCounter(anchor, totalDays) {
  const now = nowNY();
  const daysInto = dayDiff(anchor, now);
  const daysRemaining = totalDays - daysInto;

  return {
    daysInto,
    daysRemaining,
    pctInto: percent(daysInto, totalDays),
    pctRemaining: percent(daysRemaining, totalDays)
  };
}

/* ============================================
   Civil Anchors
   ============================================ */

const TERM_START = nyAnchor(2025, 1, 20, 12);
const TERM_TOTAL = 1461;

const PRIMARY_OPEN = nyAnchor(2026, 6, 9, 7);
const GENERAL_OPEN = nyAnchor(2026, 11, 3, 7);

function getPerdition() { return makeCounter(TERM_START, TERM_TOTAL); }
function getPrimaryCountdown() { return makeCounter(PRIMARY_OPEN, 1); }
function getGeneralCountdown() { return makeCounter(GENERAL_OPEN, 1); }

/* ============================================
   UTC-Based Visibility Gating
   ============================================ */

function parseIdTimestamp(id) {
  return new Date(id); // interpreted as UTC if Z is present
}

function updateTimeGatedBlocks() {
  const now = new Date(); // local time; fine for UTC comparisons

  const all = document.querySelectorAll("div[id*='T']");

  all.forEach(el => {
    const ts = parseIdTimestamp(el.id);
    if (!isNaN(ts.getTime())) {
      el.style.display = now >= ts ? "none" : "";
    }
  });
}

/* ============================================
   Perdition Display Wiring
   ============================================ */

function updatePerditionDisplay() {
  const p = getPerdition();

  const into = document.getElementById("perdition-days-into");
  const remain = document.getElementById("perdition-days-remaining");
  const pctInto = document.getElementById("perdition-pct-into");
  const pctRemain = document.getElementById("perdition-pct-remaining");

  if (into) into.textContent = p.daysInto;
  if (remain) remain.textContent = p.daysRemaining;
  if (pctInto) pctInto.textContent = p.pctInto.toFixed(2);
  if (pctRemain) pctRemain.textContent = p.pctRemaining.toFixed(2);
}

/* ============================================
   Unified Update Loop
   ============================================ */

function updateAll() {
  updatePerditionDisplay();
  updateTimeGatedBlocks();
}

document.addEventListener("DOMContentLoaded", () => {
  updateAll();
  setInterval(updateAll, 60000); // optional refresh
});