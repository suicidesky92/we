#!/bin/bash

rootcheck () {
if [ "$EUID" != "0" ];
then
  echo -e "Run script whit \033[1;5;41mroot\033[0m priveleges!"
  exit 1;
fi
}


setup_all () {

apt update
apt dist-upgrade -y

apt install -y openssh-server htop lm-sensors lxterminal vim mc wpasupplicant net-tools sudo
apt install -y i3-wm openbox obmenu obconf tint2 conky lightdm xxkb wicd network-manager nitrogen volumeicon-alsa arandr x11-xkb-utils gpicview
apt install -y xarchiver pcmanfm xfce4-clipman compton gnome-screenshot suckless-tools surf lxappearance lxappearance-obconf gnome-calculator
apt install -y firefox-esr evince libreoffice lightdm-gtk-greeter lightdm-gtk-greeter-settings
apt install -y ./openbox-themes_1.0.2_all.deb


#echo "cat /etc/passwd | grep 1000 | awk -F: '{print$1}'"
#read -p 'Username to sudo: ' myuser
myuser=$(cat /etc/passwd | grep 1000 | awk -F: '{print$1}')
usermod -a -G sudo $myuser
echo "$myuser ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

#ln -s /usr/bin/lxterminal /etc/alternatives/x-terminal-emulator
#ln -s /etc/alternatives/x-terminal-emulator /usr/bin/x-terminal-emulator


mkdir /home/$myuser/.local
mkdir /home/$myuser/.local/share

cp -rf .config /home/$myuser
cp -rf .i3 /home/$myuser
cp -rf .bashrc /home/$myuser
cp -rf .themes /home/$myuser
cp -rf lxappearance /usr/share

cp -rf icons /home/$myuser/.local/share
cp -rf icons /usr/share/
cp -rf themes/* /home/$myuser/.themes/

chown -R $myuser:$myuser /home/$myuser

sensors-detect --auto

}

helper() {
echo "arandr - for multimonitor, nitrogen - wallpaper, wicd - network manager, pcmanfm - file navigating"
echo "obconf, obmenu - OpenBox config, lxappearance - styles,  tint2conf - OpenBox panel config"

}

plymouths () {

update-pciids
VGAc=$(lspci | grep -E "VGA|3D" | awk '{print$5}')

if [ "$VGAc" = "Intel" ];
then
    echo "# KMS" | tee -a /etc/initramfs-tools/modules
    echo "intel_agp" | tee -a /etc/initramfs-tools/modules
    echo "drm" | tee -a /etc/initramfs-tools/modules
    echo "i915 modeset=1" | tee -a /etc/initramfs-tools/modules
elif [ "$VGAc" = "NVIDIA" ];
then
    echo "# KMS" | tee -a /etc/initramfs-tools/modules
    echo "drm" | tee -a /etc/initramfs-tools/modules
    echo "nouveau modeset=1" | tee -a /etc/initramfs-tools/modules
elif [ "$VGAc" = "AMD" ]; then
    echo "# KMS" | tee -a /etc/initramfs-tools/modules
    echo "drm" | tee -a /etc/initramfs-tools/modules
    echo "radeon modeset=1" | tee -a /etc/initramfs-tools/modules
else
    lspci
    echo -en "We \033[5;32mcan't\033[0m detect your video.. Chose your video manual to /etc/initramfs-tools/modules"
    read null
fi

cp -rf ./eneplymouth/ene /usr/share/plymouth/themes/
update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/ene/ene.plymouth 200
update-alternatives --set default.plymouth /usr/share/plymouth/themes/ene/ene.plymouth
update-initramfs -u

}


autofs () {
apt install udisks2 dbus dbus-user-session gvfs
}


rebooting () {
echo -e "\033[5;36mAll Done!\033[0m"
echo -en "System need \034[5;32mreboot\033[0m. y/n? "
read reqreboot
if [ "$reqreboot" = "y" ];
then
    reboot
elif [ "$reqreboot" = "n" ];
then
    exit
else
    read -p "Write y or n! " reqreboot
    if [ "$reqreboot" = "y" ];
    then
        reboot
    elif [ "$reqreboot" = "n" ];
    then
        exit
    else
        echo "Omg. Okay.. I'am exit"
        exit
    fi
fi
}

rootcheck
setup_all
plymouths
autofs
helper
rebooting


#apt install -y -qq git; git clone https://github.com/suicidesky92/we.git; cd we; ./setup.sh
