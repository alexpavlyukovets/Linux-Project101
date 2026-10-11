#!/bin/bash

echo "Starting EC2 termination analysis..."

if [[ ! -f "event_history.csv" ]]; then
    echo "Error: event_history.csv not found!"
    exit 1
fi

grep -i "^paul," event_history.csv | grep "TerminateInstances" | grep -oE 'i-[0-9a-f]+' | sort -u > result.txt

echo "Analysis completed."