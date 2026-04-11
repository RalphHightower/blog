///
/// Description: Formula for the great-circle distance between two points on a sphere
/// Requires: displayLibrary.js, holidayLibrary.js 
///


/// <summary>
/// Formula for the great-circle distance between two points on a sphere
/// </summary>
/// <param name=""></param>
/// <param name=""></param>
/// <param name=""></param>
/// <param name=""></param>
/// <returns></returns>
function haversineMilesDegrees(lat1, lon1, lat2, lon2) {
  const toRad = deg => deg * Math.PI / 180;

  const φ1 = toRad(lat1);
  const φ2 = toRad(lat2);
  const Δφ = toRad(lat2 - lat1);
  const Δλ = toRad(lon2 - lon1);

  const a = Math.sin(Δφ / 2) ** 2 +
            Math.cos(φ1) * Math.cos(φ2) *
            Math.sin(Δλ / 2) ** 2;

  const c = 2 * Math.asin(Math.sqrt(a));

  return 3958.8 * c; // miles
}

/// <summary>
/// Formula for the great-circle distance between two points on a sphere
/// </summary>
/// <param name=""></param>
/// <param name=""></param>
/// <param name=""></param>
/// <param name=""></param>
/// <returns></returns>
function haversineMilesRadians(lat1, lon1, lat2, lon2) {
  
  const φ1 = lat1;
  const φ2 = lat2;
  const Δφ = lat2 - lat1;
  const Δλ = lon2 - lon1;
  
  const a = Math.sin(Δφ / 2) ** 2 +
            Math.cos(φ1) * Math.cos(φ2) *
            Math.sin(Δλ / 2) ** 2;

  const c = 2 * Math.asin(Math.sqrt(a));

  return 3958.8 * c; // miles
}

const day = [
  { from: "ADW", to: "PBI" },
  { from: "PBI", to: "CDAV" }
];

const airports = {
  ADW:  { lat: 38.810833, lon: -76.866944 },
  PBI:  { lat: 26.683000, lon: -80.095000 },
  MEM:  { lat: 35.042000, lon: -89.979000 },
  CDAV: { lat: 39.648000, lon: -77.466000 }, // Camp David
  NY34: { lat: 40.742626, lon: -73.972923 }  // NYC 34th St Heliport
};

let total = 0;

for (const leg of day) {
  const a = airports[leg.from];
  const b = airports[leg.to];
  total += haversineMiles(a.lat, a.lon, b.lat, b.lon);
}

console.log(total);
