# --- yearly triad audit -------------------------------------------------------

audit_year=$(date +%Y)
audit_dir="$JEKYLL_ROOT/$audit_year"

log "AUDIT: starting yearly triad audit for $audit_year."

# Get sorted list of all daily files
files=($(ls "$audit_dir"/*.md | sort))

# Iterate through each file
for ((i=0; i<${#files[@]}; i++)); do
    file="${files[$i]}"
    base=$(basename "$file" .md)

    # Compute expected neighbors
    prevprev=""
    prev=""
    next=""

    if [ $i -ge 2 ]; then
        prevprev=$(basename "${files[$((i-2))]}" .md)
    fi
    if [ $i -ge 1 ]; then
        prev=$(basename "${files[$((i-1))]}" .md)
    fi
    if [ $i -lt $((${#files[@]}-1)) ]; then
        next=$(basename "${files[$((i+1))]}" .md)
    fi

    # Extract last three navigation lines
    nav=$(tail -n 3 "$file")

    # Validate PrevPrev
    if [ -n "$prevprev" ] && ! echo "$nav" | grep -q "/$prevprev/"; then
        log "AUDIT-ERROR: $base missing PrevPrev link ($prevprev)."
    fi

    # Validate Prev
    if [ -n "$prev" ] && ! echo "$nav" | grep -q "/$prev/"; then
        log "AUDIT-ERROR: $base missing Prev link ($prev)."
    fi

    # Validate Next (forward link)
    if [ -n "$next" ] && ! echo "$nav" | grep -q "/$next/"; then
        log "AUDIT-ERROR: $base missing forward link ($next)."
    fi

    # Self-link check
    if echo "$nav" | grep -q "/$base/"; then
        log "AUDIT-ERROR: $base contains self-link."
    fi
done

log "AUDIT: yearly triad audit complete for $audit_year."

# --- weekly audit summary ------------------------------------------------------

dow=$(date +%u)   # Monday = 1

if [ "$dow" -eq 1 ]; then
    summary_status="OK"

    # If any AUDIT-ERROR lines appeared in the last week’s logs, mark as FAIL
    if grep -q "AUDIT-ERROR" "$JEKYLL_ROOT/logs/index-update.week-"*".log" 2>/dev/null; then
        summary_status="FAIL"
    fi

    # If any FALLBACK occurred last week, mark as WARN
    if grep -q "FALLBACK" "$JEKYLL_ROOT/logs/index-update.week-"*".log" 2>/dev/null; then
        summary_status="WARN"
    fi

    # Write the weekly summary line
    echo "$(date '+%Y-%m-%d') WEEKLY-AUDIT: $summary_status (year=$audit_year)" >> "$LOG_FILE"

    log "WEEKLY-AUDIT: summary for $audit_year = $summary_status."
fi
