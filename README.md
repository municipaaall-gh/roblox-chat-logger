# roblox-chat-logger

## what this is
a simple client side roblox chat logger that writes textchat messages to local txt files and creates folders per game automatically

## output structure
exec-root\logs\game-name\dd-mm-yyyy hh-mm-ss.txt

## example log
started - dd-mm-yyyy hh-mm-ss  
game - game-name

[hh-mm-ss] user1: hello  
[hh-mm-ss] user2: hi

## requirements
an executor that supports
- writefile()
- appendfile()
- makefolder()
