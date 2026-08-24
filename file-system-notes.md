File System Notes

Linux file-system commands I discovered:

1. pwd

pwd

Prints the full path of the directory I am currently working in. It is useful for confirming my location before creating, moving, or deleting files.

2. ls -lah

ls -lah

Lists the contents of the current directory in detail. The -a option includes hidden files, while -h displays file sizes in an easier-to-read format such as KB or MB.

3. mkdir -p

mkdir -p projects/demo

Creates a directory and any missing parent directories. In this example, it creates projects first and then creates demo inside it.

4. cp

cp test.txt projects/demo/

Copies a file to another location. The original test.txt remains in place, and a second copy is created inside projects/demo.

5. tail -f

tail -f /var/log/auth.log

Displays the latest lines of a file and continues showing new lines as they are added. This is particularly useful for monitoring log files in real time. Press Ctrl+C to stop it.