#!/usr/bin/env bash

TARGETS=("zeek" "rita")
OUTFILE="tool_usage_metrics.csv"
INTERVAL=5

if [ ! -f "$OUTFILE" ]; then
    echo "timestamp;pid;tool;cpu_percent;mem_mb;vsz_kb;rss_kb;cmd" > "$OUTFILE"
fi

while true; do
    ts=$(date +"%Y-%m-%d %H:%M:%S")

    for tool in "${TARGETS[@]}"; do
        PIDS=$(pgrep "$tool")

        for pid in $PIDS; do

            stats=$(ps -p "$pid" -o %cpu,%mem,rss,cmd --no-headers)

            cpu=$(echo "$stats" | awk '{print $1}')        # CPU percent
            mem_percent=$(echo "$stats" | awk '{print $2}') # RAM percent of total system memory
            rss=$(echo "$stats" | awk '{print $3}')         # memory in KB
            cmd=$(echo "$stats" | cut -d " " -f4-)          # extract command

            mem_mb=$(awk "BEGIN {print $rss/1024}")         # convert KB → MB

            echo "$ts;$pid;$tool;$cpu;$mem_mb;$mem_percent;$cmd" >> "$OUTFILE"
        done
    done

    sleep "$INTERVAL"
done

