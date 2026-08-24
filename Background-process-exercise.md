Exercise: Start, Find, and Kill a Background Process

1. Start a long-running process

sleep 300 &

This starts a harmless sleep process that would normally run for 300 seconds. The & sends it to the background so the terminal remains available.

2. Find its PID

The shell prints the PID when the process starts. You can also find it with:

pgrep -a sleep

Or search the full process list:

ps aux | grep '[s]leep 300'

The exercise process used PID 7 in this environment. PIDs are assigned dynamically, so the number will be different on another system.

3. Kill the process

kill 7

The normal kill command sends SIGTERM, requesting that the process terminate cleanly. Replace 7 with the PID shown on your own machine.

4. Verify that it stopped

ps -p 7

If the process has stopped, it will no longer appear in the process list.

Recommended command sequence

The safest method is to capture the PID immediately using $!, which represents the PID of the most recently started background process:

sleep 300 &
process_id=$!

echo "Started PID: $process_id"
ps -p "$process_id" -o pid,stat,cmd

kill "$process_id"
wait "$process_id" 2>/dev/null

ps -p "$process_id"

Commands used

sleep 300 & — starts a 300-second process in the background.

$! — returns the PID of the most recent background process.

pgrep -a sleep — finds matching processes and shows their command lines.

ps -p <PID> — displays information about one specific PID.

kill <PID> — requests that the selected process stop.

wait <PID> — waits for the background process to finish and clears its completed job entry from the shell.