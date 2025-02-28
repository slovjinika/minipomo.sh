# Pomodoro Timer

This script implements a simple command-line pomodoro timer.  It allows you to track your work in focused intervals, with customizable durations.

## Features

* Customizable Pomodoro Duration: Set the length of your work intervals using the -t flag (e.g., ./minipomo.sh -t 30m for a 30-minute pomodoro).  Defaults to 25 minutes if no duration is specified.
* Timer Display:  Shows a countdown timer in the format HH:MM:SS.
* Session Logging: Records the start time and duration of each pomodoro session to a .pomodoro_history file.
* Interactive Prompts: Asks before starting each pomodoro session, allowing you to take breaks or quit as needed.

## Usage

1.  Save the script: Save the provided code as pomodoro.sh.
2.  Make it executable: Run chmod +x pomodoro.sh.
3.  Run the script:

    *   To start with the default 25-minute pomodoro: `bash minipomo.sh` or `./minipomo.sh`
    *   To start with a custom duration (e.g., 30 minutes): `bash pomodoro.sh -t 30m`


## Options

*   -t <duration>: Sets the pomodoro duration in minutes (e.g., -t 25m, -t 30m, -t 45m).  The 'm' is required.


## Session History

The script maintains a history of your pomodoro sessions in the file .pomodoro_history in the same directory where you run the script.  Each line in this file represents a session and contains the timestamp and duration.

## Example./minipomo.sh -t 30m

This will start a 30-minute pomodoro timer.  Once the timer finishes, it will prompt you to start another one or quit.  The session will be logged to .pomodoro_history.


## Error Handling

The script includes error handling for invalid input:

*   Invalid duration: If you provide an invalid duration format (e.g., not a number followed by 'm'), it will display an error message and exit.
*   Unknown options:  If you use an unknown command-line option, it will display an error message and exit.


## Dependencies

This script requires bash (most Unix-like systems have this by default).  No other external dependencies are needed.
