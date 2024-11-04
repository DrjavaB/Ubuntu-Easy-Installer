#!/bin/bash

# Install Zsh
sudo apt-get update
sudo apt-get install zsh -y

# Change the default shell for the root user
sudo chsh -s /bin/zsh root

# Check the default shell for the root user
echo $SHELL

# Install wget and git
sudo apt-get install wget git -y

# Install Oh My Zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Copy the Zsh configuration template
/bin/cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc

# Source the Zsh configuration
source $HOME/.zshrc
