#!/bin/bash
echo -e "\033[7mENE PLYMOUTH THEME installation program\033[0m"
#Detect if Ene theme exists
if [ -d "/usr/share/plymouth/themes/ene" -o -d "/lib/plymouth/themes/ene" ]; then
	echo -e "\033[31m\033[1mWARNING\033[0m\033[31m : I detect than ENE plymouth theme already exists ?Do you want to continue ?\033[0m"
	echo -e "\033[1mpress ENTER to continue else press CTRL+C to exit\033[0m"
	read nope
fi

echo -e "\033[33m---COPYRIGHT---\n\033[0m"
echo -e "\033[36mTheme and script by Logan Tann.You can do what do you want for the source."
echo -e "images found in google images : https://goo.gl/FDq1qY and https://goo.gl/cEKPeY \n\033[0m"
echo -e "\033[33m---INFO---\n"
echo -e "\033[36mThis script will install automatically this plymouth theme . Please visit \033[4mREADME.txt\033[0m\033[36m if you have any problem.\033[0m"
echo -e "\033[31mthis script is DANGEROUS ! I am not responsible for any problem.\033[0m \nAre you sure to execute it ? \n\033[1mPress Enter to continue\033[0m"
read nope
echo -e "\033[33m\n---LET'S GO!----\n\033[0m"

#Detect the default folder
if [ -d "/usr/share/plymouth/themes/" ]; then
	echo -e "\033[32mI found the default folder for your Linux !\033[0m"
	echo -e "\033[36mit's /usr/share/plymouth/themes/\n\033[0m"
	default="/usr/share/plymouth/themes/"

elif [ -d "/lib/plymouth/themes/" ]; then
	echo -e "\033[31mI found the default folder for your Linux !\033[0m"
	echo -e "\033[36mit's /lib/plymouth/themes/\n\033[0m"
	default="/lib/plymouth/themes/"

else
	echo -e "\033[31mError : no default folder found for install this plymouth theme\033[0m"
	echo -e "\033[36m/lib/plymouth/themes/ and /usr/share/plymouth/themes/ not found\033[0m"
	echo -e "\033[1mPlease specify a folder : \033[0m"
	read default

fi

echo -e "\033[36mDefault folder set to [\033[31m$default\033[0m]\n"

echo -e "\033[33m---COPYING FILES---\n\033[0m"
	sudo cp -r ene $default/ene

echo -e "\033[33m---UPDATING THEMES---\n\033[0m"
	sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/ene/ene.plymouth 200

echo -e "\033[1mDo you want to set this theme as default bootanimation ? [Y/n]\033[0m"
	read doesdefault
	if [ $doesdefault = "Y" ]; then
		echo -e "\033[33m---SETING THIS THEME TO DEFAULT BOOTANIM---\n\033[0m"
		sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/ene/ene.plymouth
		echo -e "\033[33m---UPDATING INITRAMFS---\n\033[0m"
		sudo update-initramfs -u
	fi
echo -e "\033[32mInstallation finished"
echo -e "\033[1mDo you want to restart your PC ? [Y/n]\033[0m"
	read doesreboot
	if [ $doesreboot = "Y" ]; then
		echo rebooting
		reboot
		read nope
fi