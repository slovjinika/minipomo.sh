#!/bin/bash

# Parameter handling
while getopts ":t:" opt; do
  case $opt in
    t)
      pomodoro_duration=$(echo "$OPTARG" | sed 's/m$//') # Remove 'm' from the end
      if [[ ! "$pomodoro_duration" =~ ^[0-9]+$ ]]; then
        echo "Error: Invalid pomodoro time value. Use 'Xm' format, where X is the number of minutes."
        exit 1
      fi
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

# Default values
if [[ -z "$pomodoro_duration" ]]; then
  pomodoro_duration=25
fi

HISTORY_FILE=".pomodoro_history"

# Function to display the timer
display_timer() {
  local remaining_time="$1"
  local hours=$((remaining_time / 3600))
  local minutes=$(( (remaining_time % 3600) / 60 ))
  local seconds=$(( remaining_time % 60 ))
  printf "\r%02d:%02d:%02d  " "$hours" "$minutes" "$seconds"
}

# Function to run the timer
run_timer() {
  local duration="$1"
  local start_time=$(date +%s)
  local end_time=$((start_time + duration * 60))

  while true; do
    remaining_time=$((end_time - $(date +%s)))
    if [ $remaining_time -le 0 ]; then
      echo -e "\nTime's up!"
      break
    fi
    display_timer "$remaining_time"
    sleep 1
  done
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
  echo -e "\nPomodoro №$((pomodoro_count + 1)) (start? [y/n] or q to quit):"
  read input

  case "$input" in
    "y"|"Y")
      run_timer "$pomodoro_duration"
      log_session "Pomodoro" "$pomodoro_duration"
      pomodoro_count=$((pomodoro_count + 1))
      ;;
    "n"|"N")
      continue
      ;;
    "q"|"Q")
      break
      ;;
    *)
      echo "Invalid input."
      continue
      ;;
  esac
done

echo -e "\nSession history:"
cat "$HISTORY_FILE"

echo -e "\nEnd."
