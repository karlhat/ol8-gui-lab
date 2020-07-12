#!/bin/bash

#
# 
# Description:  Vagrant box installs Oracle Linux 8.0 for a lab
# Author: Carlos Alberto Ramirez Rendon
# 
#
# 


#enable repos
yum config-manager --enable ol8_appstream
yum config-manager --enable ol8_baseos_latest
yum clean all

#install GUI

yum groupinstall -y "Server with GUI"

echo 'Installing packages required for webapp demo'
yum install git  -y
yum install gcc -y 
yum install httpd  -y
yum install php  -y
yum install php-json -y
yum install php-xml -y
yum install php-pdo -y
yum install php-mbstring -y
yum install php-fpm -y
yum install sqlite -y
systemctl enable --now httpd


cd /var/www/ && { git clone https://github.com/ilosuna/phpsqlitecms.git ; mv /var/www/html{,.old}; ln -s /var/www/phpsqlitecms /var/www/html; }
cd /var/www/html/cms/
mkdir files media
chgrp -R apache cache data files media
chmod 2775 cache data files media
chmod 664 data/*.sqlite


# Disabling SELinux, permisse mode increase disk I/O 
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config


# Enabling sshd password access
sed -re 's/^(PasswordAuthentication)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config
systemctl restart sshd.service 2>&1 | tee -a /tmp/bootstrap.log


#MOTD

echo "" > /etc/motd
echo "Welcome to Oracle Linux Server release 8" >> /etc/motd
echo "" >> /etc/motd
echo "
########################################################################" >> /etc/motd
echo '* Double click on  vm, then login as demo user with' >> /etc/motd 
echo '  password Welcome1' >> /etc/motd 
echo "" >> /etc/motd

systemctl set-default graphical.target

####tune screen
cat << EOF > /etc/gdm/custom.conf
[daemon]
# Uncoment the line below to force the login screen to use Xorg
WaylandEnable=false
DefaultSession=gnome=xorg.desktop
[security]

[xdmcp]

[chooser]

[debug]
# Uncomment the line below to turn on debugging
#Enable=true


EOF

grub2-set-default 1

#adding user demo
useradd demo
#setting password for users 
echo "Welcome1" | passwd --stdin demo
echo "Welcome1" | passwd --stdin vagrant
echo "Welcome1" | passwd --stdin root 


clear
echo ""
echo ""
echo "##################################################################"
echo ' VM will be ready after reboot'
echo 'To get started, on your VirtualBox Manager :'
echo '  Double click on ol8-gui-lab VM, then loggin as vagrant user password Welcome1'
sleep 3
echo ' rebooting VM'
reboot


