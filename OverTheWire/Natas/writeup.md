natas0: To solve this challenge, the only thing needed is that you go into developer tools on the website (or click view page source), at which point you will find the password in an html comment

natas1: this challenge was solved the same way as the last one, it seems they expected the use of right click and view page source on the last one, not dev tools. I just used dev tools to get the password which was in a comment like before

natas2: There was nothing on the page for natas2. Taking a look at the html code, we see that next to the text, there's an image tag with source "files/pixel.png". We can see that this is a relative path, implying that the webpage includes a files directory. When I appended "/files" to the url, I got a list of available files which included "users.txt" with the username and password for the next level.

natas3: 
