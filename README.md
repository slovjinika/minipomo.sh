# MiniPomo: A Minimalist Pomodoro Timer

MiniPomo is a lightweight, command-line based Pomodoro timer designed for simplicity and efficiency.  It helps you focus your work using the Pomodoro Technique, tracking your sessions and providing a clean, distraction-free experience.

## Features

* Minimalist Design:  Focuses on core Pomodoro functionality without unnecessary features.
* Customizable Pomodoro Length: Easily set the duration of your work intervals using the -t flag.
* Simple Timer: Displays a clear countdown timer in minutes and seconds.
* Session Logging:  Records your Pomodoro sessions with timestamps to a history file.
* Intuitive Interface: Uses simple prompts for starting and managing Pomodoros.

## Usage

1.  Save the script: Save the provided code as minipomo.sh.
2.  Make it executable:  Run chmod +x minipomo.sh.
3.  Run the script:

    *   To start a 25-minute Pomodoro (default): ./minipomo.sh
    *   To specify a custom duration (e.g., 30 minutes): ./minipomo.sh -t 30m

## Options

*   -t <duration>: Sets the Pomodoro duration in minutes (e.g., -t 25m, -t 30m). The 'm' is required.

## Session History

miniPomo keeps a history of your Pomodoro sessions in the file .pomodoro_history in the same directory where you run the script. Each line contains a timestamp and the duration of the session.

## Example./minipomo.sh -t 25m

This will start a 25-minute Pomodoro timer.  After the timer finishes, you'll be prompted to start another or quit.

## Error Handling

miniPomo includes basic error handling for:

*   Invalid Duration:  Reports an error if you provide an invalid duration format.
*   Unknown Options: Reports an error for unknown command-line options.


## Dependencies

miniPomo only requires bash, which is available on most Unix-like systems.


## Contributing

Contributions are welcome!  If you find any bugs or have suggestions for improvements, please open an issue or submit a pull request.
