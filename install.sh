clear
cd
rm -rf flutter .* myapp/* myapp/.*
mkdir ubuntu-fs
cd ubuntu-fs
echo "Downloading Ubuntu...."
wget http://cdimage.ubuntu.com/ubuntu-base/releases/20.04/release/ubuntu-base-20.04.4-base-amd64.tar.gz -O ubuntu.tar.gz
echo "Extracting Ubuntu"
mkdir ubuntu
tar -xf ubuntu.tar.gz -C ubuntu &> /dev/null
rm ubuntu.tar.gz
echo "Downloading Proot"
wget -O proot "https://downloads.sourceforge.net/project/proot.mirror/v5.3.0/proot-v5.3.0-x86_64-static?ts=gAAAAABo2hXN2r2g99TJNV9gPdRhsBvKOupjqoVyyL5FD9-YabatbTwIAbd-yCFeLO5AfqWkb3PeBgQ1mhHw2e94gppk0IZ2FQ%3D%3D&use_mirror=master&r="
chmod +x proot
echo "cd ~/ubuntu-fs && ./proot -0 -r ubuntu -b /sys -b /proc -b /etc/resolv.conf -b /dev -w /root  /usr/bin/env -i HOME=/root  PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin TERM=$TERM LANG=C.UTF-8 /bin/ustart" >> start.sh
chmod +x start.sh
cd ubuntu/root
cat >> .bashrc << EOF 
apt update 
apt install sudo wget curl -y
useradd -m -s /bin/bash ubuntu
echo "ubuntu:ubuntu" | chpasswd
echo "ubuntu  ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/ubuntu
clear
echo "Ubuntu defalut password is ubuntu"
sudo apt install nano curl systemctl dropbear firefox dbus-x11 --no-install-recommends --no-install-suggests -y
sudo apt install xfce4 xfce4-terminal  --no-install-recommends --no-install-suggests -y
sudo apt install tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer  --no-install-recommends --no-install-suggests -y
echo "Download playit"
echo "root:ubuntu" | sudo chpasswd
wget https://github.com/playit-cloud/playit-agent/releases/download/v0.16.2/playit-linux-amd64 -O /bin/playit
chmod +x /bin/playit
wget https://raw.githubusercontent.com/mineproness/free-vps-with-firebase-studio/refs/heads/main/setup.sh
bash setup.sh
rm -rf /root/*
exit
EOF
cd ..
cd usr/bin
cat >> "ustart" << EOF
echo "[*] Fixing Sudo"
chmod 4577 /bin/sudo
echo "[*] Start Dropbear"
dropbear -p 2222 
echo "Note: The root password is ubuntu. and ubuntu user password is ubuntu"
sleep 19
echo "[*] Start Playit"
playit
EOF
chmod +x ustart
cd ~/ubuntu-fs
./proot -0 -r ubuntu -b /sys -b /proc -b /etc/resolv.conf -b /dev -w /root  /usr/bin/env -i HOME=/root  PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin TERM=$TERM LANG=C.UTF-8 /bin/bash
