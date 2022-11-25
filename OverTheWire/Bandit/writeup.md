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

bandit13: There's a file called "sshkey.private" provided. We simply ssh into the server with user "bandit14" with the private key to get to the next level, from there we can gain the password in "/etc/bandit\_pass/bandit14". The command for ssh with the private key is "ssh bandit14@localhost -p 2220 -i sshkey.private"

bandit14: They ask you to send the current password to port 30000 on the machine to get the next level's password. I did a bit of research on sending data to a port, and it seemed that netcat (nc) was the answer. Netcat can send arbitrary tcp and udp data. The command I used is: "nc localhost 30000" then inputted the password. I then got the next password as a response.  

bandit15: There are 2 ways to solve this. One way is very similar to the previous challenge, except instead of using "nc" command, I used "ncat" which is very similar yet slightly different. ncat gives the ability to use ssl, so when I ran "ncat --ssl localhost 30001" then inputted the password, I got the correct response. The second way to solve this was using "openssl". I ran the command "echo [password] | openssl s\_client -connect localhost:30001 -ign\_eof" to get the correct result from the server.

bandit16: The challenge said to use a similar technique as the last challenge, except the correct port was in the range 31000-32000, and that it would be an open port with ssl configured. I thought to use nmap with a version scan: "nmap -sC -sV -vv -p 31000-32000 localhost". This gave me an idea of which ports were open and had ssl. It looked like there were 2, so i tried both and found that one of them worked when I ran "ncat --ssl localhost 31790" then inputted the password for bandit15. I got an indication that it was correct and got an ssh private key back. From there we take the same steps as the previous challenge to use the ssh key to log into the next challenge.

bandit17: to solve this level, only one command is needed. The challenge tells that the line that has been changed between passwords.old and passwords.new is the password for the next level. I simply ran the command "diff passwords.old passwords.new to obtian it"

bandit18: Logging in through ssh was at first unsuccessful, as was indicated by the challenge description, then i tried logging into bandit17 then switching to bandit18 since it only blocked on ssh login. That was unsuccessful, so I did some research. I found that you can send commands using ssh by putting the command in quotes, and since i knew the next level's password was stored in the home directory, I tried this command: 'ssh bandit18@bandit.labs.overthewire.org -p 2220 "cat readme"', then inputted the password. Success! I got the contents of the file.

bandit19: I found a binary file (executable) called "bandit20-do" in bandit19's home directory (found out it is a binary using the file command). I played around with it, and it seemed to be executing commands as bandit20, so I had the program print out bandit20's password using the command "./bandit20-do cat /etc/bandit\_pass/bandit20"

bandit20: This was an interesting challenge and I honestly needed some help figuring it out, but it wasn't too difficult. This challenge presents you with a binary that can connect to any port on the local system and returns the password to the next level if provided with bandit20's password as input. The problem is you as the user don't know what port to provide it, and there's no way to provide direct input since it asks for a port. The solution is to create a 'server' on a random port that returns bandit20's password when connected to, and so that you can provide the server's port to the suconnect binary. To do this, run the command "echo '<password>' | nc -l localhost <port#>", then I go back to the suconnect binary and run "./suconnect <port#>" with the same port number as I started the server with. This was successful and returned the next challenge's password.

bandit21: This challenge was an introduction to cron. To solve it, I navigated to /etc/cron.d as the challenge hinted. There I saw a cron job labelled "cronjob\_bandit22". I showed the contents of the file, which showed that a certain script is run at reboot (full path was included). I cat'd the contents of the script and saw that the contents of /etc/bandit\_pass/bandit20 are dumped into a random file in /tmp. I simply inspected the contents of that file and got the password to the next level.

bandit22: This challenge was similar to the previous one. It had the same basic steps except the script run by the cron job had a bit more going on. The script was copying bandit23's password into a file in /tmp, but the file's name was the hash of a string. The script got the hash using the command "echo I am user $myname | md5sum | cut -d ' ' -f 1" where $myname is just the result of whoami (bandit23), so I ran that command in the terminal to get the hash, then displayed the password with "cat /tmp/<hash>"

bandit23: This challenge was fairly simple, and started off the same as the previous challenges. I went to the directory /etc/cron.d and found the script running for bandit24. This script executed all files (besides . and ..) in the directory /var/spool/bandit24/foo then deleted them, and had a 60 second timeout. So to get the password (and since this had to be privileged), I created a shell script in a directory I created (/tmp/bandit24/) that runs "cat /etc/bandit\_pass/bandit24 > /tmp/bandit24/password", which copies the password into /tmp/bandit24/password. From there I changed the perms on the shell script and the password file, then copied the shell script into /var/spool/bandit24/foo so the cronjob can run it. I then waited a bit then checked the password file, and voila, success!

bandit24: To solve this challenge, I created a script that brute-forces number combinations to the port specified in the challenge description. This script contains a for loop that iterates through 0000-9999 and pipes the output of "password number" to "nc localhost 30002". This was successful and gave the password to the next challenge. The script is listed in this directory.

bandit25: Trying to connect to bandit26 over ssh with the private key provided doesn't work because of the default shell. To find the current shell of bandit26, I used "cat /etc/passwd | grep bandit26" to get the current shell of bandit26. When inspecting the contents, we see that it opens a txt file using the command "more". We know that when a file is larger than the current window, then the "more" command goes into paging mode. We exploit this fact by making the terminal window very small and entering into paging mode, so that when using ssh to try and get into the machine, it enters paging mode instead of printing to the console and kicking us out. Once in the paging mode, we can hit "v" to enter vim mode, then use the command ":set shell=/bin/bash" -> ":shell" to set the shell to /bin/bash then enter shell mode, giving us access to the home directory, also allowing us to read the contents of /etc/bandit\_pass/bandit26

bandit26: This challenge was much simpler. I got to bandit26 using the same technique as the previous challenge. I found a binary in bandid26's home directory called bandit27-do which ran commands as user bandit27, so I used it to display the contents of /etc/bandit\_pass/bandit27, giving me the password.

bandit27: The solution for this challenge was very simple because of my previous experience with git. To solve it, I simply created a directory in /tmp and navigated to it, then ran the command "git clone ssh://bandit27-git@localhost:2220/home/bandit27-git/repo" (note the port specifier after localhost) to clone the repository, then read the contents of "README" to get the password for the next level

bandit28: This challenge was very useful, and not something I had done with git before. To solve this, I had to revert to a previous commit in the repository shown using "git log". I then used "git checkout <commit id>" to temporarily view the previous commit and read the README.md file with the data not hidden, obtaining the password for the next level. Here's a good resource on how to revert to a previous commit: https://stackoverflow.com/questions/4114095/how-do-i-revert-a-git-repository-to-a-previous-commit

bandit29: This challenge was similar to the last one, except the readme said there was no password in production, which led me to think of different branches. I knew how to use "git branch" to switch branches, but some research let me learn that by using the "-r" flag with git branch, I could get a list of branches of the remote repository, which is quite useful. I used this to switch to the dev branch and get the password from the readme. 

bandit30: This challenge was...challenging. I didn't find anything using the previous techniques (file searching, branches, commits, etc.), The solution was tagging, using "git tag" to show the available tags. There was one tag called "secret", and when I used "git show secret", it returned the password for the next level. I did get online help and can't say I completely understand git tags though...

bandit31: This challenge was fairly simple and was about pushing to remote repos. To solve, get the git repo like before then run "echo 'May I come in?' \> key.txt" to create the file and add the needed string. Then use "git add -f key.txt" -> "git commit -m 'anything'" -> "git push", at which point you enter the password for bandit30 and get tehnext password back.

bandit32: I did not figure this one out on my own. I figured there was a trick to it, and tried different things, but ended up searching online. Linux variables include $SHELL, $PATH, etc. which I knew was a start. The solution to this challenge was to break out of this uppercase shell by inputting "$0" which is a linux var that holds a reference to your current shell (try it!). This is similar to $SHELL (which i tried) but it seems their uppercase shell deals with that case. Once you break out of their uppercase shell, you will find that you are user bandit33, since that is who it ran as, at which point you can read the password from /etc/bandit\_pass/bandit33
 
