bandit0: Use 'ls' then 'cat readme' to get the flag

bandit1: The trick is to use './' before the name of the file '-' in order to read it, since - means multiple things in linux, so you need to specify the current dir

bandit2: The trick is to escape the spaces in the filename - "spaces\ in\ the\ filename" (or get your shell to do it for you hehe)

bandit3: The trick was to change into the directory then the flag is in a hidden file -> "cd inhere" -> "cat .hidden"

bandit4: The flag was in one of the files (-file07) in the "inhere" directory. It was the only one with ASCII text, so this command can be run "file ./\* | grep ASCII" to find the ASCII file

bandit5:  
