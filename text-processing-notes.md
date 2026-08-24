Task 5: Text Processing

This task covers searching, filtering, transforming, and combining text with grep, awk, sed, and pipes.

grep: search for matching text:

Search for lowercase error in a log file:

grep "error" /var/log/syslog

Search recursively for TODO inside a project directory:

grep -r "TODO" ~/projects/

Useful options:

-i — ignore uppercase and lowercase differences.

-r — search through directories recursively.

-n — display matching line numbers.

-v — display lines that do not match.

Count case-insensitive occurrences of failed in an authentication log:

grep -i "failed" /var/log/auth.log | wc -l

The pipe sends matching lines to wc -l, which counts them. The log may require sudo, and some systems use journalctl instead of /var/log/auth.log.

awk: process fields and columns:

Print the user and command from the process list:

ps aux | awk '{print $1, $11}'

Print usernames and home directories from /etc/passwd:

awk -F: '{print $1, $6}' /etc/passwd

-F: sets the field separator to a colon.

$1 represents the first field.

$6 represents the sixth field.

Passing the filename directly to awk avoids the unnecessary cat /etc/passwd | awk ... pipeline.

sed: select or replace text:

Display text with every occurrence of old replaced by new:

sed 's/old/new/g' file.txt

s means substitute.

g replaces every match on each line instead of only the first.

Without -i, the result is printed without modifying the original file.

Print lines 10 through 20:

sed -n '10,20p' file.txt

-n suppresses normal output.

p prints the selected lines.

Pipes: connect commands:

A pipe (|) sends the standard output of one command into the next command:

grep "error" /var/log/syslog | awk '{print $1, $2, $3}' | sort | uniq

This pipeline:

Finds lines containing error.

Prints the first three fields.

Sorts the output.

Removes adjacent duplicate lines.

Using grep directly on the file is simpler than starting the chain with cat.

Challenge: users whose shell is /bin/bash

Command:

awk -F: '$7 == "/bin/bash" {print $1}' /etc/passwd

How it works:

/etc/passwd stores account information in colon-separated fields.

-F: tells awk to split each line at colons.

$7 is the account's login shell.

$7 == "/bin/bash" selects only exact /bin/bash matches.

{print $1} prints the username from the first field.

Verified output in the practice environment:

root
vscode
oai

The usernames will vary between systems.

An alternative grep and cut solution is:

grep ':/bin/bash$' /etc/passwd | cut -d: -f1