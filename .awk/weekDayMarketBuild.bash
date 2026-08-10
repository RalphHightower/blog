#!/usr/bin/env bash
set -euo pipefail

# --- config ---------------------------------------------------------

JEKYLL_ROOT="/path/to/your/jekyll/site"
YEAR_DIR="$JEKYLL_ROOT/$(date +%Y)"
AWK_SCRIPT="/path/to/your/closing_indexes.awk"
LOG_FILE="$JEKYLL_ROOT/logs/index-update.log"
LOCK_FILE="/tmp/index-update.lock"

GIT_ENABLE=true
GIT_REMOTE="origin"
GIT_BRANCH="main"

# --- helpers --------------------------------------------------------

log() {
    mkdir -p "$(dirname "$LOG_FILE")"
    printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >> "$LOG_FILE"
}

cleanup() {
    rm -f "$LOCK_FILE"
}
trap cleanup EXIT

# --- lockfile -------------------------------------------------------

if [ -e "$LOCK_FILE" ]; then
    log "LOCK: index-update already running, exiting."
    exit 0
fi
touch "$LOCK_FILE"

# --- weekend skip ---------------------------------------------------

dow=$(date +%u)   # 1=Mon ... 7=Sun
if [ "$dow" -ge 6 ]; then
    log "SKIP: weekend (dow=$dow), no index update."
    exit 0
fi

# --- date math ------------------------------------------------------

today=$(date +%Y-%m-%d)
yesterday=$(date -d "yesterday" +%Y-%m-%d)
daybefore=$(date -d "2 days ago" +%Y-%m-%d)

today_file="$YEAR_DIR/$today.md"
yesterday_file="$YEAR_DIR/$yesterday.md"

mkdir -p "$YEAR_DIR"

log "START: index update for $today (yesterday=$yesterday, daybefore=$daybefore)"

# --- data retrieval + AWK -> markdown -------------------------------

# You can wrap your data fetch here (curl, Python, etc.) and pipe into AWK.
# Example placeholder:
# curl "https://example.com/index-feed?date=$today" | awk -f "$AWK_SCRIPT" > "$today_file"

awk -f "$AWK_SCRIPT" > "$today_file"

log "MARKDOWN: generated $today_file via AWK."

# --- append triad navigation to today's file ------------------------

cat >> "$today_file" <<EOF

[Day Before Yesterday](/$daybefore/)
[Yesterday](/$yesterday/)
[Today](/$today/)
EOF

log "NAV: appended triad to $today_file."

# --- fix triad + remove self-link in today's file -------------------

# Replace last three lines with the canonical triad
# (GNU sed; adjust -i '' for macOS/BSD)
sed -i -e "\$c [Day Before Yesterday](/$daybefore/)" \
       -e "\$a [Yesterday](/$yesterday/)" \
       -e "\$a [Today](/$today/)" "$today_file"

# Remove self-link (today)
sed -i "/\/$today\//d" "$today_file"

log "NAV: normalized triad and removed self-link in $today_file."

# --- update yesterday's file to point forward to today --------------

if [ -f "$yesterday_file" ]; then
    sed -i "s|\[$yesterday\]|[$today]|g" "$yesterday_file"
    sed -i "s|/$yesterday/|/$today/|g" "$yesterday_file"
    log "NAV: updated forward link in $yesterday_file -> $today."
else
    log "WARN: yesterday file $yesterday_file not found; forward link not updated."
fi

# --- navigation validator ------------------------------------------------------

validate_nav() {
    local file="$1"
    local label="$2"

    # Extract last three navigation lines
    nav=$(tail -n 3 "$file")

    # Expected patterns
    exp_prevprev="\/$daybefore\/"
    exp_prev="\/$yesterday\/"
    exp_today="\/$today\/"

    # Check presence
    if ! echo "$nav" | grep -q "$exp_prevprev"; then
        log "NAV-ERROR: $label missing PrevPrev link ($daybefore)."
        return 1
    fi

    if ! echo "$nav" | grep -q "$exp_prev"; then
        log "NAV-ERROR: $label missing Prev link ($yesterday)."
        return 1
    fi

    if echo "$file" | grep -q "$today" && echo "$nav" | grep -q "$exp_today"; then
        log "NAV-ERROR: today file $file contains self-link."
        return 1
    fi

    # Yesterday file SHOULD contain today's link
    if echo "$file" | grep -q "$yesterday" && ! echo "$nav" | grep -q "$exp_today"; then
        log "NAV-ERROR: yesterday file $file missing forward link to today."
        return 1
    fi

    log "NAV: $label navigation validated."
    return 0
}

# Validate today's file
validate_nav "$today_file" "TODAY"

# Validate yesterday's file (if it exists)
if [ -f "$yesterday_file" ]; then
    validate_nav "$yesterday_file" "YESTERDAY"
fi
# --- optional git commit + push -------------------------------------


if [ "$GIT_ENABLE" = true ]; then
    cd "$JEKYLL_ROOT"
    git add "$today_file" "$yesterday_file" "$LOG_FILE" 2>/dev/null || true
    if ! git diff --cached --quiet; then
        git commit -m "Daily closing indexes for $today" || log "GIT: commit failed."
        git push "$GIT_REMOTE" "$GIT_BRANCH" || log "GIT: push failed."
        log "GIT: committed and pushed changes for $today."
    else
        log "GIT: no changes to commit."
    fi
fi

log "DONE: index update for $today."

###### Log rotation
log="$JEKYLL_ROOT/logs/index-update.log"
weekstamp=$(date +%Y-%m-%d)
rot="$JEKYLL_ROOT/logs/index-update.week-$weekstamp.log"

# Rotate on Mondays (1 = Monday)
dow=$(date +%u)
if [ "$dow" -eq 1 ] && [ -f "$log" ]; then
    mv "$log" "$rot"
    touch "$log"
fi

find "$JEKYLL_ROOT/logs" -name "index-update.week-*.log" -mtime +56 -delete

# --- lockfile protection ------------------------------------------------------

LOCK_FILE="/tmp/weekDayMarketBuild.lock"

# If lock exists, exit safely
if [ -e "$LOCK_FILE" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') LOCK: weekDayMarketBuild already running, exiting." >> "$JEKYLL_ROOT/logs/index-update.log"
    exit 0
fi

# Create lock
touch "$LOCK_FILE"

# Ensure lock is removed on exit, even if script errors
cleanup() {
    rm -f "$LOCK_FILE"
}
trap cleanup EXIT

# --- git auto commit & push ---------------------------------------------------

if [ "$GIT_ENABLE" = true ]; then
    cd "$JEKYLL_ROOT"

    # Stage only the files that changed
    git add "$today_file" "$yesterday_file" "$LOG_FILE" 2>/dev/null || true

    # If there are staged changes, commit them
    if ! git diff --cached --quiet; then
        git commit -m "Daily closing indexes for $today"
        git push "$GIT_REMOTE" "$GIT_BRANCH"
        log "GIT: committed and pushed changes for $today."
    else
        log "GIT: no changes to commit."
    fi
fi

# --- missing file fallback ----------------------------------------------------

if [ ! -f "$yesterday_file" ]; then
    log "FALLBACK: yesterday file $yesterday_file missing; creating stub."

    mkdir -p "$YEAR_DIR"

    cat > "$yesterday_file" <<EOF
---
title: "Closing Indexes for $yesterday"
layout: post
---

Stub file created automatically because the expected daily file was missing.

[Day Before Yesterday](/$daybefore/)
[Yesterday](/$yesterday/)
[Today](/$today/)
EOF

    # Remove self-link from the stub (yesterday shouldn't link to itself)
    sed -i "/\/$yesterday\//d" "$yesterday_file"

    log "FALLBACK: stub created for $yesterday_file."
fi

# --- daily health report ------------------------------------------------------

status="OK"

# If any NAV-ERROR lines appeared earlier in the log for today, mark as WARN
if grep -q "NAV-ERROR" "$LOG_FILE"; then
    status="WARN"
fi

# If fallback was triggered, mark as FALLBACK
if grep -q "FALLBACK" "$LOG_FILE"; then
    status="FALLBACK"
fi

# If git push failed, mark as GIT-FAIL
if grep -q "GIT: push failed" "$LOG_FILE"; then
    status="GIT-FAIL"
fi

# Write the health line
echo "$(date '+%Y-%m-%d') HEALTH: $status (today=$today, yesterday=$yesterday, daybefore=$daybefore)" >> "$LOG_FILE"

# --- monthly archive sweep ----------------------------------------------------

dom=$(date +%d)   # day of month (01–31)

if [ "$dom" -eq 1 ]; then
    log "ARCHIVE: starting monthly archive sweep."

    # Remove weekly logs older than 90 days (~3 months)
    find "$JEKYLL_ROOT/logs" -name "index-update.week-*.log" -mtime +90 -delete

    # Remove daily logs older than 30 days (if any exist)
    find "$JEKYLL_ROOT/logs" -name "index-update.log.*" -mtime +30 -delete

    # Remove any stray audit files older than 120 days
    find "$JEKYLL_ROOT/logs" -name "audit-*.log" -mtime +120 -delete

    log "ARCHIVE: monthly sweep complete."
fi
