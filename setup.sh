rm -rf /etc/profile
cat >> "/etc/profile" << EOF
/etc/skel/.bashrc
export PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin 
export TERM=\$TERM 
export LANG=C.UTF-8
EOF
