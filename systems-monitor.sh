#!/bin/bash

set -euo pipefail

timestamp=$(date +%F_%H-%M-%S)
log_file="system_monitor_$timestamp.log"

read_cpu_times() {
    awk '/^cpu / {
        idle_time = $5 + $6
        total_time = 0
        for (field = 2; field <= NF; field++) {
            total_time += $field
        }
        print total_time, idle_time
        exit
    }' /proc/stat
}

read -r total_before idle_before < <(read_cpu_times)
sleep 1
read -r total_after idle_after < <(read_cpu_times)

total_difference=$((total_after - total_before))
idle_difference=$((idle_after - idle_before))

cpu_usage=$(awk -v total="$total_difference" -v idle="$idle_difference" 'BEGIN {
    if (total > 0) {
        printf "%.1f", 100 * (total - idle) / total
    } else {
        printf "0.0"
    }
}')

generate_report() {
    echo "========================================"
    echo "        Linux System Monitor"
    echo "========================================"
    echo "Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Hostname:  $(hostname)"
    echo

    echo "CPU Usage"
    echo "---------"
    echo "Current CPU usage: ${cpu_usage}%"
    echo

    echo "Memory Usage"
    echo "------------"
    free -h | awk 'NR == 2 {
        printf "Total: %s\nUsed:  %s\nFree:  %s\n", $2, $3, $4
    }'
    echo

    echo "Disk Usage"
    echo "----------"
    df -h --output=source,size,used,avail,pcent,target -x tmpfs -x devtmpfs
    echo

    echo "Top 5 Processes by Memory"
    echo "-------------------------"
    if process_list=$(ps -eo pid,user,%mem,%cpu,comm --sort=-%mem 2>/dev/null); then
        printf '%s\n' "$process_list" | sed -n '1,6p'
    else
        echo "Process information is unavailable in this environment."
    fi
    echo
    echo "========================================"
}

generate_report | tee "$log_file"
echo "Report saved to: $log_file"