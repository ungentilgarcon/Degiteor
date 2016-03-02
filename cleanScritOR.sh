#specify environement
#!/bin/bash

#stop services
#TODO stop selectively
forever stopall

#loop through args projects
for DEGITEOR in "$@"
do
echo $DEGITEOR
if [ -f /home/$DEGITEOR/gitrep/.configDEGITEOR_$DEGITEOR ];
then
   echo "File $FILE  exist, deleting folder" >&2
rm -rf /home/$DEGITEOR
else
  echo "are you sure this is a DEGITEOR folder?"
fi
#check if users exist
   ret=false
   getent passwd $DEGITEOR >/dev/null 2>&1 && ret=true
    if $ret; then
    echo "yes the user exists, deleting"
    userdel $DEGITEOR
#if not then echo bug

  else
    echo "No, the user does not exist"
  fi

done
