#!/usr/bin/env bash
# input: 0-1
# output: 0-100

# stdin volume: $VALUE [MUTED]

if [[ $3 == "[MUTED]" ]]; then
    echo "0"
    exit 0
fi

echo $2 | awk '$0=$1"*100"' | bc | sed 's/\..*//'
