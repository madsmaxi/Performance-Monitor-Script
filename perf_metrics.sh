                    
#!/usr/bin/env bash

# Hvor CSV-filen skal gemmes
OUTFILE="resource_stats.csv"

# Lav header hvis filen ikke findes endnu
if [ ! -f "$OUTFILE" ]; then
    echo "timestamp;cpu_used_percent;mem_used_mb;mem_total_mb;load1;lo>
fi

# Evt. justér intervallet her (sekunder)
INTERVAL=5

while true; do
ts=$(date +"%Y-%m-%d %H:%M:%S")

    # CPU: tag "idle" fra top og regn 100 - idle
    cpu_used=$(top -bn1 | grep "Cpu(s)" | sed "s/,/./g" \
        | awk '{for(i=1;i<=NF;i++){if($i ~ /id/){idle=$(i-1);}}} END {>

    # RAM i MB
    read mem_total mem_used _ < <(free -m | awk '/^Mem:/{print $2" "$3>

    # Load average 1, 5 og 15 min
    read load1 load5 load15 _ < <(awk '{print $1" "$2" "$3" "$4}' /pro>

    # Skriv til CSV
    echo "$ts;$cpu_used;$mem_used;$mem_total;$load1;$load5;$load15" >>>

    sleep "$INTERVAL"
done

