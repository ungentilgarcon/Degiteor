#specify environement
#!/bin/bash

#stop services
#TODO stop selectively
forever stopall

#loop through args projects
for DEGITEOR in "$@"
do
echo $DEGITEOR
if [ ! -f /home/$DEGITEOR/gitrep/.configDEGITEOR_$DEGITEOR ];
then
   echo "File $FILE does not exist, creating skeleton
   execute again when config file inited." >&2
#check if users exist
   ret=false
   getent passwd $DEGITEOR >/dev/null 2>&1 && ret=true
   if $ret; then
    echo "yes the user exists"
#if not then init dirs
  else
    echo "No, the user does not exist"
    useradd $DEGITEOR
    mkdir /home/$DEGITEOR
    mkdir /home/$DEGITEOR/gitrep
    touch /home/$DEGITEOR/.profile
    chown -R $DEGITEOR:$DEGITEOR /home/$DEGITEOR
#init tools -nvm meteor demeteorizer forever
#nvm
 su -c " cd /home/$DEGITEOR && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash " $DEGITEOR
#meteor
# su -c " cd /home/$DEGITEOR && curl https://install.meteor.com/ | sh" $DEGITEOR

  fi

  DATABASE=${DEGITEOR//[^[:alnum:]]/}
   touch /home/$DEGITEOR/gitrep/.configDEGITEOR_$DEGITEOR
   echo "#$DEGITEOR Config file, please edit with su-c or else to preserve file attributes
GITDIR=
PORT=
BRANCH=
ROOT_URL=
MAIL_URL=
#This one we shouldn't have to touch
MONGO_URL='mongodb://localhost:27017/$DATABASE'
NVM_VER='v0.10.40' #DEFAULT GOOD CHOICE
#GITDIR='https://github.com/FOO.git'
#PORT="3001"
#BRANCH='master'
#ROOT_URL='https://chat.FOO.XYZ'
#MAIL_URL='smtp://USERNAME:PASS@PROVIDER.XYZ:587'
   " > /home/$DEGITEOR/gitrep/.configDEGITEOR_$DEGITEOR
  chown -R $DEGITEOR:$DEGITEOR /home/$DEGITEOR/gitrep/.configDEGITEOR_$DEGITEOR
#for Meteor
#cp "/home/$DEGITEOR/.meteor/packages/meteor-tool/1.1.10/mt-os.linux.x86_64/scripts/admin/launch-meteor" /usr/bin/meteor

else
echo "File $DEGITEOR config exist, building..."

#echo "I'm not supposed to be there yet"
#SOURCE FILE
source  /home/$DEGITEOR/gitrep/.configDEGITEOR_$DEGITEOR
#add godd env for app
su -c "echo DEGITEOR=$DEGITEOR >>/home/$DEGITEOR/.profile" $DEGITEOR
su -c "echo '. /home/$DEGITEOR/gitrep/.configDEGITEOR_$DEGITEOR' >>/home/$DEGITEOR/.profile" $DEGITEOR
#su -c "echo 'PATH=/home/$DEGITEOR/.meteor:$PATH' >>/home/$DEGITEOR/.profile" $DEGITEOR
su -c "echo 'PATH=/home/$DEGITEOR/.nvm/bin/node-$NVM_VER-linux-x64:$PATH' >>/home/$DEGITEOR/.profile" $DEGITEOR
su -c "echo 'PATH=/home/$DEGITEOR/node_modules/forever/bin/:$PATH' >>/home/$DEGITEOR/.profile" $DEGITEOR
su -c "echo 'PATH=/home/$DEGITEOR/.nvm/$NVM_VER/bin/:$PATH' >>/home/$DEGITEOR/.profile" $DEGITEOR
#su -c "echo 'PATH=/home/$DEGITEOR/node_modules/demeteorizer/bin/:$PATH' >>/home/$DEGITEOR/.profile" $DEGITEOR
#FOR DEBUGGING
su -c "echo $GITDIR "  $DEGITEOR
su -c "echo $PORT "  $DEGITEOR
su -c "echo $BRANCH "  $DEGITEOR
su -c "echo $ROOT_URL "  $DEGITEOR
su -c "echo $MONGO_URL "   $DEGITEOR
su -c "echo $NVM_VER "   $DEGITEOR

#for NVM
cd /home/$DEGITEOR
#su -c  "/home/$DEGITEOR/.nvm/nvm.sh" $DEGITEOR
#su -c "NVM_DIR=/home/"$DEGITEOR"/.nvm" $DEGITEOR
#su -c ". $NVM_DIR/nvm.sh " $DEGITEOR
#for Meteor
#su -c "PATH=/home/$DEGITEOR/.meteor:$PATH" $DEGITEOR
#su -c "PATH=/home/$DEGITEOR/.nvm:$PATH" $DEGITEOR
#install workign nvm and use it
su -c ". /home/$DEGITEOR/.profile && cd /home/$DEGITEOR && nvm install $NVM_VER" $DEGITEOR
su -c ". /home/$DEGITEOR/.profile && cd /home/$DEGITEOR && nvm use $NVM_VER" $DEGITEOR
#the rest
su -c ". /home/$DEGITEOR/.profile && cd /home/$DEGITEOR && ~/.nvm/$NVM_VER/bin/npm install demeteorizer forever npm-install-missing fibers underscore source-map-support semver" $DEGITEOR

su -c "PATH=/home/$DEGITEOR/.nvm/bin/node-$NVM_VER-linux-x64:$PATH" $DEGITEOR

su -c  " . /home/$DEGITEOR/.profile && cd /home/$DEGITEOR/gitrep && git clone $GITDIR" $DEGITEOR
su -c  " . /home/$DEGITEOR/.profile && cd /home/$DEGITEOR/gitrep/$DEGITEOR/ &&  git branch --set-upstream-to=origin/$BRANCH"  $DEGITEOR
su -c  " . /home/$DEGITEOR/.profile && cd /home/$DEGITEOR/gitrep/$DEGITEOR/ &&  git pull " $DEGITEOR
#: <<'END'
#su -c  " . /home/$DEGITEOR/.profile && cd /home/$DEGITEOR/gitrep/$DEGITEOR/ && /home/$DEGITEOR/node_modules/demeteorizer/bin/demeteorizer --output ~/my-meteor-deployment " $DEGITEOR
#su -c  " . /home/$DEGITEOR/.profile && cd /home/$DEGITEOR/my-meteor-deployment/bundle/ && /home/$DEGITEOR/node_modules/npm-install-missing/bin/npm-install-missing  " $DEGITEOR
echo "now you need to modify your script to use forever instead of sh... easy, it is usually some sh file, inspire yourself from the command below"
echo "#su -c  " export ROOT_URL=$ROOT_URL && export MONGO_URL=$MONGO_URL && export PORT=$PORT && export MAIL_URL=$MAIL_URL && . /home/$DEGITEOR/.profile && cd /home/$DEGITEOR &&  /home/$DEGITEOR/node_modules/forever/bin/forever start /home/$DEGITEOR/my-meteor-deployment/bundle/main.js" $DEGITEOR"
#END
fi
done
