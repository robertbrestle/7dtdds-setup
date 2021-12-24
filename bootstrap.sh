#!/bin/bash

# system update
sudo yum update -y

# 32-bit libraries
sudo yum install glibc.i686 libstdc++.i686 libstdc++48.i686 -y

# pre-reqs
sudo yum install mesa-libGLU libXcursor libXrandr -y

# location for steamcmd
mkdir -p /opt/games/bin

## create scripts
# install/update steam games
echo -e '#!/bin/bash\nAPP_ID=$1\nAPP_DIR=$2\nSTEAM_USER=$3\nSTEAM_PASS=$4\n/opt/games/steamcmd/steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir ${APP_DIR} +app_update ${APP_ID} +exit' > /opt/games/bin/steamgame_update.sh

# install/update 7dtdds
echo -e '#!/bin/bash\n/opt/games/bin/steamgame_update.sh 294420 /opt/games/7days $1 $2' > /opt/games/bin/update_7days.sh

# dedicated server run script
echo -e '#!/bin/bash\n/opt/games/7days/startserver.sh -configfile=/opt/games/7days/serverconfig.xml' > /opt/games/startserver.sh

# Set script permissions
chmod 750 /opt/games/startserver.sh
chmod 750 /opt/games/bin/*.sh

# download steamcmd
wget 'http://media.steampowered.com/installer/steamcmd_linux.tar.gz' -O /opt/games/steamcmd_linux.tar.gz
tar -xzvf /opt/games/steamcmd_linux.tar.gz && rm -f /opt/games/steamcmd_linux.tar.gz

# steam user
adduser --home /opt/games steam
cp /etc/skel/.* /opt/games
chown -R steam:steam /opt/games