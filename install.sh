#!/usr/bin/bash


rm -rf ~/.config/{tmux,nvim}


## Tmux Installation
sudo apt install -y tmux
mkdir -p ~/.config/tmux/
cp tmux.conf ~/.config/tmux/tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# tmux -L tmux-tmp new-session -d
# tmux source-file ~/.config/tmux/tmux.conf
# tmux run-shell "~/.config/tmux/plugins/tpm/bin/install_plugins"
# tmux -L 

tmux -L tpm source-file ~/.tmux.conf \; \
     run-shell "~/.tmux/plugins/tpm/bin/install_plugins" \; \
     kill-server

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
echo "PS1='\[\e[48;5;239m\] staff@maslab \[\e[0;38;5;239m\]${TRIANGLE}\[\e[0m\] \w \[\e[38;5;112m\]\$\[\e[0m\] '" >> ~/.bashrc
