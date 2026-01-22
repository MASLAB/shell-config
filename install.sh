#!/usr/bin/bash


## Tmux Installation
sudo apt install -y tmux
mkdir -p ~/.config/tmux/
cp tmux.conf ~/.config/tmux/tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux source ~/.config/tmux/tmux.conf
bash ~/.config/tmux/plugins/tpm/scripts/update_plugin.sh


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
rm -r ~/.config/nvim/.git

cat mappings.lua >> ~/.config/nvim/lua/mappings.lua
cat init.lua >> ~/.config/nvim/lua/init.lua
cp vimtmux.lua ~/.config/nvim/lua/plugins/vimtmux.lua


## Setup PS1
echo "PS1='\[\e[48;5;239m\] staff@maslab \[\e[0;38;5;239m\]${TRIANGLE}\[\e[0m\] \w \[\e[38;5;112m\]\$\[\e[0m\] '" >> ~/.bashrc
