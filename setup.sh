cat >> "/etc/profile" << EOF
export PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin 
export TERM=\$TERM 
export LANG=C.UTF-8
export HOSTNAME=ubuntu
EOF
cat >> "/bin/desktopstart" << EOF
vncserver -kill :* &> /dev/null
vncserver -xstartup startxfce4
EOF
chmod +x /bin/desktopstart

