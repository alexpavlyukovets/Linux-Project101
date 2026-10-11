#!/bin/bash

# Input and output files
INPUT_FILE="auth.log"
OUTPUT_FILE="invalid_user.txt"

# Check if the log file exists
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Error: $INPUT_FILE not found."
    exit 1
fi

# Analyze invalid SSH usernames
grep -oE 'Invalid user [^ ]+ from' "$INPUT_FILE" |
    awk '{print $3}' |
    sort |
    uniq -c |
    sort -nr > "$OUTPUT_FILE"

echo "Analysis completed."
echo "Results saved to $OUTPUT_FILE"