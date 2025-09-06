RED='\033[0;31m'
NC='\033[0m'
clear
echo -e ${RED}Updating and Upgrading Package.... ${NC}
apt update
apt upgrade -y 
clear
echo -e ${RED}Installing Xfce4 , xrdp ,firefox..... ${NC}
apt install xfce4 -y
apt install sudo wget curl git  -y
apt install firefox -y
clear
echo -e ${RED}Configure the desktop... ${NC}
rm -rf /etc/xrdp/startwm.sh
cat > "/etc/xrdp/startwm.sh" <<- EOF

#!/bin/sh
# xrdp X session start script (c) 2015, 2017 mirabilos
# published under The #!/bin/sh
# XRDP Startup Script

# Set locale
if [ -r /etc/default/locale ]; then
    . /etc/default/locale
    export LANG LANGUAGE
fi

# Start Xfce session
startxfce4



EOF

echo -e ${RED}Adding Commands... ${NC}
cat > "/bin/rdpstart" <<- EOF

ROOT=$(whoami)
if [ $ROOT == root ]; then
  echo "Are You Root user"
  exit
fi
service xrdp start
while [ true ]; do
  ssh -p 443 -R0:127.0.0.1:3389 tcp@free.pinggy.io
  echo Starting Again
  sleep 10
done


EOF

echo -e ${RED}Chmod The ALl Files... ${NC}
chmod +x /bin/rdpstart
chmod +x /etc/xrdp/startwm.sh
echo -e ${RED}Enter Your Infomation of Your Account ${NC}

rm -rf /etc/sudoers
cat > "/etc/sudoers" <<- EOF
 
#
# This file MUST be edited with the 'visudo' command as root.
#
# Please consider adding local content in /etc/sudoers.d/ instead of
# directly modifying this file.
#
# See the man page for details on how to write a sudoers file.
#
Defaults        env_reset
Defaults        mail_badpass
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

# Host alias specification

# User alias specification

# Cmnd alias specification

# User privilege specification
root    ALL=(ALL:ALL) ALL
ALL ALL=(ALL) NOPASSWD:ALL
# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL

# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL

# See sudoers(5) for more information on "#include" directives:

#includedir /etc/sudoers.d


EOF

read -p "Enter Your Username: " USERNAME
adduser $USERNAME
clear
echo -e "${RED}When You went start the rdp Just Type 'rdpstart' on your root user${NC} and When You went Stop Just Type 'Q' and agian 'Q' and then Just Press Control + C"
echo "Then You get a ip just Connect in to remote desktop app or in Android Open Remote Desktop 8"
