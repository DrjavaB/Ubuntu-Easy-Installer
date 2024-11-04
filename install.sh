#!/bin/bash

trap - SIGINT

release=$(lsb_release -r | tail -n1 | awk '{print $2}' | cut -d. -f1)

case $release in
20 | 21)
    codename=focal
    ;;
22 | 23)
    codename=jammy
    ;;
24 | 25)
    codename=noble
    ;;
esac

echo ubuntu default configs and key bindings
. default-setup.sh

sudo apt update -y
sudo apt upgrade -y

# dependencies installation
sudo apt-get install -y --fix-missing \
    dbus-x11 \
    gnome-shell-extensions \
    gnome-tweaks \
    dconf-editor \
    curl \
    vim \
    git \
    nemo \
    zsh \
    neovim \
    mc \
    gdebi

# set nemo as default file manager
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
gsettings set org.nemo.desktop show-desktop-icons true
gsettings set org.gnome.desktop.background show-desktop-icons false

PS3="Select your Webservice: "

select webservice in nginx apache2; do
    printf "\e[32m%s\e[0m will be installed\n" $webservice
    case $webservice in
    nginx)
        sudo apt-get install -y $webservice
        break
        ;;
    apache2)
        sudo apt-get install -y $webservice
        break
        ;;
    *)
        echo "Invalid option $REPLY"
        ;;
    esac
done
sudo systemctl enable --now $webservice

if [ ! -d $HOME/.oh-my-zsh ]; then
    echo ohmyzsh installing...
    bash ohmyzsh.sh
fi

# ZSH plugins
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
git clone https://github.com/unixorn/fzf-zsh-plugin.git --depth 1 $ZSH_CUSTOM/plugins/fzf-zsh-plugin
git clone https://github.com/zsh-users/zsh-autosuggestions.git --depth 1 $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/marlonrichert/zsh-autocomplete.git --depth 1 $ZSH_CUSTOM/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git --depth 1 $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

echo php installing...
. php.sh

echo composer installing...
. composer.sh

echo laravel installing...
. laravel.sh

echo vscode installing...
. vscode.sh

echo docker installing...
. docker.sh

echo mariadb installing...
sudo apt install -y mariadb-server

echo postgresql installing...
. postgresql.sh

echo nodeJS installing...
. node.sh

echo pnpm installing...
. pnpm.sh

echo Redis Stack installing...
. redis-stack.sh

echo RabbitMQ Stack installing...
. rabbit.sh

echo Google Chrome installing...
. google-chrome.sh

sed -i 's/plugins=(git)/plugins=(\n\tgit\n\tubuntu\n\tlaravel\n\tsymfony\n\taliases\n\tdocker\n\tfzf-zsh-plugin\n\tzsh-autosuggestions\n\tzsh-syntax-highlighting\n)/g' $HOME/.zshrc

cp .aliases $HOME/.aliases
cp .variables $HOME/.variables
cp .functions $HOME/.functions

cat <<EOF >>$HOME/.zshrc

. $HOME/.aliases
. $HOME/.variables
. $HOME/.functions
EOF

git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
