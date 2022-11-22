bandit0: Use 'ls' then 'cat readme' to get the flag

bandit1: The trick is to use './' before the name of the file '-' in order to read it, since - means multiple things in linux, so you need to specify the current dir

bandit2: The trick is to escape the spaces in the filename - "spaces\ in\ the\ filename" (or get your shell to do it for you hehe)

bandit3: The trick was to change into the directory then the flag is in a hidden file -> "cd inhere" -> "cat .hidden"

bandit4: The flag was in one of the files (-file07) in the "inhere" directory. It was the only one with ASCII text, so this command can be run "file ./\* | grep ASCII" to find the ASCII file

bandit5: use command "find . -size 1033c" to find a file of size 1033

bandit6: use command "find / -user bandit7 -group bandit6 -size 33c"

bandit7: use command "cat data.txt | grep millionth"

bandit8: use command "cat data.txt | sort | uniq -cu" to sort the results, count the number of occurrences, and get the unique result

bandit9: 
