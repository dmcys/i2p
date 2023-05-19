#!bin/sh
read -p "You want install it on ArchLinux? y/n" option;
if $option == "y"; then
#Arch Linux Build
  sudo pacman -S jdk8-openjdk
  sudo pacman -S ant
  sudo pacman -S gettext
  sudo ant installer-linux
  cp -r ./installer/resources/runplain.sh ./runplain.sh
else
  echo "Exiting..";
fi
