clear
echo -e  "Updating, Upgrading, and Installing Some Packages..."
apt update &> /dev/null
apt upgrade -y &> /dev/null
apt install wget curl git sudo iputils-ping nano -y &> /dev/null
sleep 5
echo "Fixing Sudo Errors..."
chmod 455 /usr/bin/sudo &> /dev/null
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
echo "Adding Commands...."
cat > "/bin/rdpstart" <<- EOF
service xrdp start
while [ true ]; do

 ssh -p 443 -R0:127.0.0.1:3389 tcp@free.pinggy.io 
 echo "It Tunnel is Starting.... To Stop Tunnel Just Press CONTROL+C"
 sleep 10
done
EOF
chmod +x /bin/rdpstart &> /dev/null
cat > "/bin/rdpstop" <<- EOF
service xrdp stop
EOF
chmod +x /bin/rdpstop &> /dev/null
clear
echo "Creating Account...."
read -p "Enter Your Username: " USERNAME
adduser $USERNAME
apt install xrdp -y
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
chmod +x /etc/xrdp/startwm.sh
clear 
echo "Installing Xfce4..."
apt install xfce4 xfce4-terminal firefox -y
clear
echo "Type 'rdpstart' to Start Rdp and see it is a ip just enter in rdp. You See a Interface with username and password. Just Type Your username password. and Enjoy your rdp"
