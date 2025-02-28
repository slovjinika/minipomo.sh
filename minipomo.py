import time
import argparse
import datetime

def display_timer(remaining_seconds):
    minutes, seconds = divmod(remaining_seconds, 60)
    print(f"\r{minutes:02d}:{seconds:02d}  ", end="", flush=True)

def run_timer(duration_seconds):
    end_time = time.time() + duration_seconds
    while time.time() < end_time:
        remaining_seconds = int(end_time - time.time())
        display_timer(remaining_seconds)
        time.sleep(1)
    print("\nTime's up!")

def log_session(type, duration_minutes):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(".pomodoro_history", "a") as f:
        f.write(f"{timestamp} {type} ({duration_minutes} min)\n")

def main():
    parser = argparse.ArgumentParser(description="Simple Pomodoro timer.")
    parser.add_argument("-t", "--time", metavar="DURATION", help="Pomodoro duration in minutes (e.g., 25m)")
    args = parser.parse_args()

    duration_minutes = 25
    if args.time:
        try:
            duration_minutes = int(args.time[:-1])
            if duration_minutes <= 0:
                raise ValueError
        except (ValueError, IndexError):
            print("Error: Invalid duration. Use 'Xm' format (X being minutes).", file=sys.stderr)
            return

    duration_seconds = duration_minutes * 60
    pomodoro_count = 0

    while True:
        input_str = input(f"Pomodoro №{pomodoro_count + 1} (start? [y/n] or q to quit): ")
        if input_str.lower() == "y":
            run_timer(duration_seconds)
            log_session("Pomodoro", duration_minutes)
            pomodoro_count += 1
        elif input_str.lower() == "n":
            continue
        elif input_str.lower() == "q":
            break
        else:
            print("Invalid input.")

    print("\nSession history:")
    try:
        with open(".pomodoro_history", "r") as f:
            print(f.read())
    except FileNotFoundError:
        print("No history found.")
    print("End.")

if __name__ == "__main__":
    import sys
    main()


