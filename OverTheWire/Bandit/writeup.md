bandit0: Use 'ls' then 'cat readme' to get the flag

bandit1: The trick is to use './' before the name of the file '-' in order to read it, since - means multiple things in linux, so you need to specify the current dir

bandit2: The trick is to escape the spaces in the filename - "spaces\ in\ the\ filename" (or get your shell to do it for you hehe)

bandit3: The trick was to change into the directory then the flag is in a hidden file -> "cd inhere" -> "cat .hidden"

bandit4: The flag was in one of the files (-file07) in the "inhere" directory. It was the only one with ASCII text, so this command can be run "file ./\* | grep ASCII" to find the ASCII file

bandit5: use command "find . -size 1033c" to find a file of size 1033

bandit6: use command "find / -user bandit7 -group bandit6 -size 33c"

bandit7: use command "cat data.txt | grep millionth"

bandit8: use command "cat data.txt | sort | uniq -cu" to sort the results, count the number of occurrences, and get the unique result

bandit9: just run "strings data.txt | grep ======="

bandit10: use command "base64 -d data.txt" since the data in data.txt is base64 encoded  

bandit11: I figured it was some kind of caesar cipher, which it was. It turns out it's rot13, so i plugged the contents of "data.txt" into cyber chef to decode and got the flag. There are multiple ways to go about this, including scripting.

bandit12: I'll get back to this later and add more detail. The solution invovled creating a temporary directory in /tmp, then move data.txt from your (bandit12) home directory, then using "xxd -r data.txt > data" to undo the hex dump and put the result into "dat". Then you use "file <filename>" to figure out what type of file it is (compressed) then rename the file to have the correct extension -> use the associated tool to decompress -> use file command -> repeat. This goes on until you get to human-readable ASCII data.
