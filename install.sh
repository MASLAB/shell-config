#!/usr/bin/bash


rm -rf ~/.config/{tmux,nvim}


## Tmux Installation
sudo apt install -y tmux
mkdir -p ~/.config/tmux/
cp tmux.conf ~/.config/tmux/tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

tmux -L tmux-tmp new-session -d
tmux -L tmux-tmp source-file ~/.config/tmux/tmux.conf
tmux -L tmux-tmp run-shell "~/.config/tmux/plugins/tpm/bin/install_plugins"
tmux -L tmux-tmp kill-server

## Nvim Installation
ARCHITECTURE=$(uname -m)
if [ "$ARCHITECTURE" == "aarch64" ]; then
  ARCHITECTURE="arm64"
fi
curl -o nvim -LO "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$ARCHITECTURE.appimage"
chmod u+x nvim
sudo mv nvim /usr/bin/nvim

mkdir -p ~/.config/nvim/
git clone https://github.com/NvChad/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

cat mappings.lua >> ~/.config/nvim/lua/mappings.lua
cat init.lua >> ~/.config/nvim/lua/init.lua
cp vimtmux.lua ~/.config/nvim/lua/plugins/vimtmux.lua


## Setup PS1
sudo apt install -y fonts-powerline
TRIANGLE=$'\ue0b0'
echo "PS1='\[\e[48;5;239m\] \u@\h \[\e[0;38;5;239m\]${TRIANGLE}\[\e[0m\] \w \[\e[38;5;112m\]\$\[\e[0m\] '" >> ~/.bashrc
source ~/.bashrc
