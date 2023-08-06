#!/bin/bash

# Apps to install
app_install=(
  grml-zsh-config
  zsh
  terminator
  sublime-text-4
  bash-complete
  mkinitcpio
  timeshift-autosnap
  grub-btrfsd
  inotify-tools
  ufw
  wget
  brave
  flatpak
  zsh-autosuggestions
  zsh-syntax-highlighting
)

#function to show progress bar
show_progress() {
  while ps | grep $1 &> /dev/null;
  do
    echo -n "."
    sleep 2
  done
  echo -en "Done!\n"
  sleep 2
}

# Package Validation and install.
install_software() {
  # Validate if package is installed
  if yay -Q $1 &>> /dev/null ; then
    echo -e "$COK - $1 is already installed."
  else
    # Install Package
    echo -en "$CNT - Now installing $1 ."
    yay -S --noconfirm $1 &>> $INSTLOG &
    show_progress $!
    # Validate install
    if yay -Q $1 &>> /dev/null ; then
      echo -e "\e[1A\e[K$COK - $1 was installed."
    else
      # Package failed install
      echo -e "\e[1A\e[K$CEK - $1 installation has failed, please check the install log."
      exit
    fi
  fi 
}


# Install Package Manager YAY
if [ ! -f /sbin/yay ]; then  
  echo -en "$CNT - Installing yay."
  git clone https://aur.archlinux.org/yay.git &>> $INSTLOG
  cd yay
  makepkg -si --noconfirm $>> ../$INSTLOG &
  show_progress $!
  if [ -f /sbin/yay ]; then
    echo -e "\e[1A\e[K$COK - yay installed"
    cd ..
  
    # Update the yay database
    echo -en "$CNT - Updating yay."
    yay -Suy --noconfirm &>> $INSTLOG & 
    show_progress $!
    echo -e "\e[1A\e[K$COK - yay updated."
  else
    # yay failed to install.
    echo -e "\e[1A\e[K$CER - yay install failed, please check the install.log"
    exit
  fi
fi

# Install Flatseal if flatpac is present
if [ -f /sbin/flatpak ]; then
  echo -en "$CNT - Installing Flatseal."
  flatpak install flathub com.githib.tchx84.Flatseal &>> $INSTLOG
  flatpak run com.githib.tchx84.Flatseal &>> $INSTLOG

fi

