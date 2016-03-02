#DEGITEOR is a script to setup and deploy in seconds to a server meteor apps stored on  gits somewhere.

The app get setup the right way, with it's files being stored under a /home/APP_NAME directory tree and run by a user without privilege, using it's own unpriviledge node and meteor installs.

###1-To install, run  a first time as root:
./scriptDEGITEOR.sh APP_NAME1 APP_NAME2 APP_NAME3 ....

###2-Then edit /home/APP_NAME/gitrep/.scriptDEGITEOR_APP_NAME
for each app (examples included), and
###3-run ./scriptDEGITEOR.sh APP_NAME1 APP_NAME2 APP_NAME3 .... again...

et voila...


No heroku no docker no extra layers...


Of course your server needs to be configured correctly, though I might append some server checks
and configs in a not-too-distant future.

DENODEOR is more or less working too to install programs using node without meteor.
the cleanscript.sh is a deinstaller for the apps .

copyright GPL v3
So far tested on various Debian installs,
Report issues, I'll be happy to fix them ;).

You like it? then star it!
