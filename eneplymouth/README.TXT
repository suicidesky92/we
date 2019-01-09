ENE PLYMOUTH THEME AND INSTALLATION SCRIPT
---Author / contact---
Script and plymouth theme by Logan Tann (Admin #shintaro of the Kagerou Project Fr Community).
website : http://kagescan.esy.es/
facebook : http://facebook.com/kagerouprojectfr
mail : < logon313 AT hotmail DOT fr >

---COPYRIGHT---

Theme and script by Logan Tann.You can do what do you want for the source.
images found in google images : https://goo.gl/FDq1qY and https://goo.gl/cEKPeY 

---EXPRESS INSTALLATION---

Run install.sh in the terminal.
Root privileges is not required for execute : this script uses SUDO !
If you don't have sudo in your PC,edit the script or try to install it !

---MANUAL INSTALLATION---

Copy the ENE folder to /usr/share/plymouth/themes/.If this folder doesn't exists,try to copy to /lib/plymouth/themes/.

Type theses commands in termial with root privileges : 

update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/ene/ene.plymouth 200
#if you want to set this theme as default bootanimation :
update-alternatives --set default.plymouth /usr/share/plymouth/themes/ene/ene.plymouth
update-initramfs -u

Reboot and enjoy !

---change bootanimation---

If you want to change the default theme,type theses commands in termial with root privileges : 

update-alternatives --config default.plymouth
update-initramfs -u

---It display black screen! Help me !---

1)Try to change the defalut resolution in GRUB.
2)If you have a NVIDIA or INTEL driver,read this web page : https://onetransistor.blogspot.fr/2016/03/plymouth-fix-nvidia.html