// Easter Sunday + Good Friday (Western/Gregorian)
// Using descriptive integer variable names

function easterAndGoodFriday(year) {
  // Golden number (Metonic cycle position)
  const goldenNumber = year % 19;

  // Century breakdown
  const century = Math.floor(year / 100);
  const yearInCentury = year % 100;

  // Century corrections
  const leapCorrection = Math.floor(century / 4);
  const centuryRemainder = century % 4;

  // Gregorian lunar corrections
  const lunarCorrection = Math.floor((century + 8) / 25);
  const solarCorrection = Math.floor((century - lunarCorrection + 1) / 3);

  // Paschal full moon index
  const paschalIndex =
    (19 * goldenNumber + century - leapCorrection - solarCorrection + 15) % 30;

  // Weekday alignment
  const yearQuarter = Math.floor(yearInCentury / 4);
  const yearQuarterRemainder = yearInCentury % 4;

  const weekdayOffset =
    (32 + 2 * centuryRemainder + 2 * yearQuarter - paschalIndex - yearQuarterRemainder) % 7;

  // Final correction for early/late Easter
  const easterAdjustment = Math.floor(
    (goldenNumber + 11 * paschalIndex + 22 * weekdayOffset) / 451
  );

  // Compute Easter month/day
  const easterMonth = Math.floor(
    (paschalIndex + weekdayOffset - 7 * easterAdjustment + 114) / 31
  ); // 3 = March, 4 = April

  const easterDay =
    ((paschalIndex + weekdayOffset - 7 * easterAdjustment + 114) % 31) + 1;

  // Build date objects
  const easter = new Date(year, easterMonth - 1, easterDay);

  const goodFriday = new Date(easter);
  goodFriday.setDate(goodFriday.getDate() - 2);

  return { easter, goodFriday };
}

// Example:
//console.log(easterAndGoodFriday(2026));
