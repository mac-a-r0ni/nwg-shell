#!/usr/bin/bash

# wget https://raw.github.com/nwg-piotr/nwg-shell/main/installer/arch.sh && chmod u+x arch.sh && ./arch.sh
sudo pacman -S --noconfirm git man-db vi xdg-user-dirs

echo Initializing XDG user directories
xdg-user-dirs-update

echo "Adding $USER to video group"
sudo usermod -aG video $USER

echo "Installing Basic AUR Package Helper"
git clone https://bitbucket.org/natemaia/baph.git || { echo "Failed cloning baph: $?"; }
cd baph || { echo "Couldn't setup baph, terminating..."; exit 1; }
sudo make install

echo "You're about to select a file manager, text editor and web browser."
echo "They need to be preinstalled now, for the key bindings to work."
echo "None of above is a shell dependency, and you're free to change them any time later."

PS3="Select file manager: "
select fm in thunar caja dolphin nautilus nemo pcmanfm;
do
    break
done

PS3="Select text editor: "
select editor in mousepad atom emacs gedit geany kate vim;
do
    break
done

PS3="Select web browser: "
select browser in chromium brave-bin google-chrome-stable epiphany falkon firefox konqueror midori opera qutebrowser seamonkey surf vivaldi-stable;
do
    break
done

echo "Installing selection: $fm $editor $browser"
baph -inN $fm $editor $browser

echo Installing nwg-shell
baph -inN nwg-shell

echo Installing initial configuration
nwg-shell-installer -w
