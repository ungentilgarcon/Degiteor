#DEGITEOR is a script to setup and deploy in seconds to a server meteor apps stored on  gits somewhere.

The app get setup the right way, with it's files being stored under a /home/APP_NAME directory tree and run by a user without privilege.

###1-To install, run  a first time as root:
./scriptDEGITEOR.sh APP_NAME1 APP_NAME2 APP_NAME3 ....

###2-Then edit /home/APP_NAME/gitrep/.scriptDEGITEOR_APP_NAME
for each app (examples included), and
###3-run ./scriptDEGITEOR.sh APP_NAME1 APP_NAME2 APP_NAME3 .... again...

et voila...



copyright GPL v3
So far tested on various Debian installs,
Report issues, I'll be happy to fix them ;).

You like it? then star it!
