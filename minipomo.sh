#!/bin/bash

# Default pomodoro duration in seconds
pomodoro_duration_seconds=1500  # 25 minutes

# Process command-line arguments
while getopts ":t:" opt; do
  case $opt in
    t)
      duration_minutes=$(echo "$OPTARG" | sed 's/m$//')
      if [[ ! "$duration_minutes" =~ ^[0-9]+$ ]]; then
        echo "Error: Invalid duration. Use 'Xm' format (X being minutes)." >&2
        exit 1
      fi
      pomodoro_duration_seconds=$((duration_minutes * 60))
      ;;
    \?)
      echo "Error: Unknown option -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Error: Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
  esac
done


HISTORY_FILE=".pomodoro_history"

# Function to display the timer
display_timer() {
  local remaining_seconds="$1"
  local minutes=$((remaining_seconds / 60))
  local seconds=$((remaining_seconds % 60))
  printf "\r%02d:%02d  " "$minutes" "$seconds"
}

# Function to run the timer
run_timer() {
  local end_time=$((SECONDS + $1))
  while (( SECONDS < end_time )); do
    remaining_seconds=$((end_time - SECONDS))
    display_timer "$remaining_seconds"
    sleep 1
  done
  echo -e "\nTime's up!"
}

# Function to log the session
log_session() {
  local type="$1"
  local duration="$2"
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo "$timestamp $type ($duration min)" >> "$HISTORY_FILE"
}

# Main loop
pomodoro_count=0
while true; do
  read -r -p "Pomodoro №$((pomodoro_count + 1)) (start? [y/n] or q to quit): " input

  case "$input" in
    [yY])
      run_timer "$pomodoro_duration_seconds"
      log_session "Pomodoro" "$((pomodoro_duration_seconds / 60))"
      pomodoro_count=$((pomodoro_count + 1))
      ;;
    [nN])
      continue
      ;;
    [qQ])
      break
      ;;
    *)
      echo "Invalid input."
      ;;
  esac
done

echo -e "\nSession history:"
cat "$HISTORY_FILE" || true # Suppress error if file doesn't exist

echo -e "\nEnd."
