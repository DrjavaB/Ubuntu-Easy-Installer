#!/bin/bash

# ubuntu default configs
sudo tee /etc/modprobe.d/snd-hda-intel.conf <<< "options snd_hda_intel power_save=0" # disable audio power saving
sudo echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER       #sudo without asking for password
sudo gsettings set org.gnome.SessionManager logout-prompt false                     #disable gnome shutdown prompt

# override key bindings
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>Page_Up', '<Super><Alt>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Page_Down', '<Super><Alt>Right']"
gsettings set org.gnome.shell.extensions.screenshot-window-sizer cycle-screenshot-sizes "[]"
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>m']"
gsettings set org.cinnamon.desktop.keybindings.wm activate-window-menu "[]"
