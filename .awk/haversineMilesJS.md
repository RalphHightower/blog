function haversineMiles(lat1, lon1, lat2, lon2) {
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
function haversineMiles(lat1, lon1, lat2, lon2) {
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

<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script id="MathJax-script" async
  src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js">
</script>
MathJax is exactly what GitHub Pages (via Jekyll) uses to render LaTeX — but the trick is that GitHub Pages does NOT enable MathJax by default. That’s why your early attempt on your photography page didn’t work. You weren’t doing anything wrong with the formulas — the engine simply wasn’t turned on yet.

Let me give you a clean, reliable way to make MathJax work on your RalphHightower/RalphHightower site, plus a ready‑to‑paste exposure‑triangle block.

---

✨ How to Enable MathJax on GitHub Pages (the reliable way)

Add this script tag anywhere in your page layout, usually in:

- _layouts/default.html, or
- directly in the Markdown page if you prefer

Place it just before </body>:

`html
<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script id="MathJax-script" async
  src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js">
</script>
`

Once that’s in place, any LaTeX you write will render.

---

📷 Exposure Triangle — MathJax‑Ready LaTeX Block

Here’s a clean, copy‑ready block you can drop straight into your photography page:

Exposure Triangle Relationships

\[
\text{Exposure} \propto \frac{t}{N^2 \cdot \text{ISO}}
\]

Where:

- \( t \) = shutter time
- \( N \) = f‑number (aperture)
- ISO = sensor/film sensitivity

Stops

A “stop” is a doubling or halving of light:

\[
\text{1 stop} = \times 2 \text{ light}
\]

Aperture stops:

\[
N \rightarrow N \cdot \sqrt{2}
\]

Shutter stops:

\[
t \rightarrow 2t
\]

ISO stops:

\[
\text{ISO} \rightarrow 2 \cdot \text{ISO}
\]

Equivalent Exposures

\[
\frac{t1}{N1^2 \cdot \text{ISO}_1}
=
\frac{t2}{N2^2 \cdot \text{ISO}_2}
\]

This is the clean mathematical backbone of the exposure triangle — and MathJax will render it beautifully once the script is enabled.

---

🧭 If you want, I can also generate:

- a Zone System block
- a combined Exposure Triangle + Zone System diagram in LaTeX
- a compact sidebar version
- or a full photography‑page section you can paste into your repo

Just tell me the style you want and I’ll shape it to fit your site.

Yes — when you write LaTeX inside your blog, MathJax is the engine that renders it.
So anything you wrap in \( ... \) or \[ ... \] is interpreted by MathJax, not by the browser directly.

Here’s a clean, copy‑ready block of the formulas you’re using, written in MathJax‑friendly LaTeX exactly the way Jekyll/Markdown expects them.

---

📐 MathJax‑Ready Formula Set

🌍 Degrees → Radians
\[
\text{rad} = \text{deg} \cdot \frac{\pi}{180}
\]

---

🛫 Haversine Formula (Great‑Circle Distance)

\[
\Delta\phi = \phi2 - \phi1
\]

\[
\Delta\lambda = \lambda2 - \lambda1
\]

\[
a = \sin^2\left(\frac{\Delta\phi}{2}\right)
    + \cos(\phi1)\cos(\phi2)\sin^2\left(\frac{\Delta\lambda}{2}\right)
\]

\[
c = 2 \cdot \arcsin\left(\sqrt{a}\right)
\]

\[
d = R \cdot c
\]

Where:

- \( R = 3958.8 \) miles
- All angles are in radians

---

🧮 Minimal JavaScript Version (MathJax‑safe)

You can drop this into a fenced code block in Markdown:

`
function haversineMiles(lat1, lon1, lat2, lon2) {
  const toRad = deg => deg * Math.PI / 180;

  const φ1 = toRad(lat1);
  const φ2 = toRad(lat2);
  const Δφ = toRad(lat2 - lat1);
  const Δλ = toRad(lon2 - lon1);

  const a = Math.sin(Δφ / 2)  2 +
            Math.cos(φ1)  Math.cos(φ2)
            Math.sin(Δλ / 2)  2;

  const c = 2 * Math.asin(Math.sqrt(a));

  return 3958.8 * c; // miles
}
`

---

If you want, I can also give you a MathJax block that explains the whole derivation in a single display equation, or a compact version for your sidebar.

You’re going to have fun with this — the exposure triangle looks great in MathJax, and the Haversine formula will fit right into your Air Force One Frequent Flyer Miles page like it was meant to be there from the start.

Here’s a clean, MathJax‑ready Exposure Triangle block you can drop straight into your photography page. It renders beautifully once MathJax is enabled.

---

📷 Exposure Triangle (MathJax‑Ready)

Exposure Relationship

\[
\text{Exposure} \propto \frac{t}{N^{2} \cdot \text{ISO}}
\]

Where:

- \( t \) = shutter time
- \( N \) = f‑number (aperture)
- ISO = sensitivity

---

Stops (Doubling / Halving of Light)

\[
\text{1 stop} = \times 2 \text{ light}
\]

Aperture stops:

\[
N \rightarrow N \cdot \sqrt{2}
\]

Shutter stops:

\[
t \rightarrow 2t
\]

ISO stops:

\[
\text{ISO} \rightarrow 2 \cdot \text{ISO}
\]

---

Equivalent Exposure

\[
\frac{t1}{N1^{2} \cdot \text{ISO}_1}
=
\frac{t2}{N2^{2} \cdot \text{ISO}_2}
\]

This is the clean mathematical backbone of the exposure triangle — compact, precise, and perfect for a photography page.

---

And yes, dropping the Haversine formula into your Air Force One Frequent Flyer Miles page is going to be a great little wink to anyone who reads closely. It fits your whole “annotated archive” aesthetic: clean math, clean structure, and a quiet sense of humor about the geometry of presidential wanderlust.

If you want, I can help you format the Haversine block in the same MathJax style so the two pages feel consistent.

Absolutely — here’s a clean, MathJax‑ready Haversine block you can drop straight into your Air Force One Frequent Flyer Miles page. It’ll render beautifully right alongside the exposure triangle.

No dependencies, no commentary — just the formulas.

---

🌍 Haversine Formula (MathJax‑Ready)

Convert Degrees → Radians

\[
\text{rad} = \text{deg} \cdot \frac{\pi}{180}
\]

---

Great‑Circle Distance Between Two Coordinates

Given:

- \( \phi1, \lambda1 \) = latitude & longitude of point 1 (radians)
- \( \phi2, \lambda2 \) = latitude & longitude of point 2 (radians)

\[
\Delta\phi = \phi2 - \phi1
\]

\[
\Delta\lambda = \lambda2 - \lambda1
\]

\[
a = \sin^2\left(\frac{\Delta\phi}{2}\right)
  + \cos(\phi1)\cos(\phi2)\sin^2\left(\frac{\Delta\lambda}{2}\right)
\]

\[
c = 2 \cdot \arcsin\left(\sqrt{a}\right)
\]

Earth radius (miles):

\[
R = 3958.8
\]

Final distance:

\[
d = R \cdot c
\]

---

If you want, I can also give you a compact sidebar version, or a “How it works” explanation written in your clean, archival style.
