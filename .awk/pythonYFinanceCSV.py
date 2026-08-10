#!/usr/bin/env python3

import yfinance as yf
from datetime import datetime
import subprocess

WL_FILE = "watchList.md"
AWK_SCRIPT = "marketFormatYahoo.awk"
CSV_OUT = "closing.csv"

# ------------------------------------------------------------
# 1. Parse wl.md into regions using alphabetical-break logic
# ------------------------------------------------------------

def parse_regions():
    regions = []
    current = []
    prev = ""

    with open(WL_FILE) as f:
        for line in f:
            if ":" not in line:
                continue
            sym, name = line.strip().split(":", 1)

            # Alphabetical break → new region
            if prev and sym < prev:
                regions.append(current)
                current = []

            current.append((sym, name))
            prev = sym

    regions.append(current)
    return regions


# ------------------------------------------------------------
# 2. Fetch pricing data using yfinance
# ------------------------------------------------------------

def fetch_prices(symbols):
    data = {}

    for sym in symbols:
        try:
            ticker = yf.Ticker(sym)
            hist = ticker.history(period="2d")

            if hist.empty:
                data[sym] = ("", "", "")
                continue

            close = hist["Close"].iloc[-1]
            prev = hist["Close"].iloc[-2] if len(hist) > 1 else close
            change = close - prev
            pct = (change / prev * 100) if prev != 0 else 0

            data[sym] = (round(close, 3), round(change, 3), round(pct, 3))

        except Exception:
            data[sym] = ("", "", "")

    return data


# ------------------------------------------------------------
# 3. Write CSV for AWK formatter
# ------------------------------------------------------------

def write_csv(data):
    with open(CSV_OUT, "w") as out:
        for sym, (close, change, pct) in data.items():
            out.write(f"{sym},{close},{change},{pct}\n")


# ------------------------------------------------------------
# 4. Run AWK formatter
# ------------------------------------------------------------

def run_awk():
    result = subprocess.run(
        ["awk", "-f", AWK_SCRIPT, CSV_OUT],
        capture_output=True,
        text=True
    )
    return result.stdout


# ------------------------------------------------------------
# 5. Build Jekyll post
# ------------------------------------------------------------

def build_jekyll(regions, data, awk_output):
    date = datetime.now().strftime("%Y-%m-%d")
    stamp = datetime.now().strftime("%Y%m%d")
    filename = f"{date}-{stamp}ClosingIndexes.md"

    region_names = [
        "Americas",
        "Europe, Middle East, and Africa",
        "Asia, Pacific",
        "Defense ETFs",
        "Energy ETFs"
    ]

    with open(filename, "w") as f:
        # Front matter
        f.write("---\n")
        f.write("layout: post\n")
        f.write("tags: [finance,investing,stocks,indexes,world stock market indexes]\n")
        f.write(f"date: {datetime.now()}\n")
        f.write(f"title: \"{date}: World Stock Market Closing Indexes\"\n")
        f.write("---\n\n")

        # Region tables
        for region_name, region_rows in zip(region_names, regions):
            f.write(f"## {region_name}\n\n")
            f.write("| Index | Closing Value | Gain/Loss | Percentage Change |\n")
            f.write("|---|---:|---:|---:|\n")

            for sym, name in region_rows:
                close, change, pct = data.get(sym, ("", "", ""))
                f.write(f"| {name} | {close} | {change} | {pct}% |\n")

            f.write("\n")

        # Append AWK formatted summary if desired
        f.write("\n\n<!-- AWK formatted summary -->\n")
        f.write(awk_output)

    return filename


# ------------------------------------------------------------
# Main
# ------------------------------------------------------------

def main():
    regions = parse_regions()

    # Flatten symbols for yfinance
    symbols = [sym for region in regions for sym, _ in region]

    data = fetch_prices(symbols)
    write_csv(data)

    awk_output = run_awk()
    filename = build_jekyll(regions, data, awk_output)

    print(f"Generated {filename}")


if __name__ == "__main__":
    main()