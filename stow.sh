#!/bin/sh

# Move "$1" out of the way so that stow can write there.
archive () {
  if [ ! -L "$1" ]; then
    sudo /bin/cp --backup=numbered "$1" "$1.orig"
    sudo rm "$1"
  fi
}

# Delete "$1" so that stow can write there.
stomp () {
  if [ ! -L "$1" ]; then
    sudo rm -rf "$1"
  fi
}

if ! [ -x "$(command -v stow)" ]; then
  echo "stow is not installed." >&2
  exit 1
fi

cd "$(dirname "$0")"

###
echo "Stowing user configs."
###

archive ../.bashrc
stow bash || exit 1

stomp ../.config/sway
stow sway || exit 1

rm ../.config/nvim/init.lua # prefer vimscript...
stow neovim || exit 1

stow foot || exit 1
stow waybar || exit 1
stow mako || exit 1
stow ssh || exit 1
stow git || exit 1
stow npm || exit 1
stow weechat || exit 1
stow yazi || exit 1
stow mpv || exit 1

rm ../.nanorc
stow nano || exit 1

echo '[[ $- != *i* ]] && return' | sudo tee /root/.bashrc > /dev/null

###
echo "Stowing root configs."
###

archive /etc/bash.bashrc
sudo chown -R 0:0 global-bash
sudo stow --target=/ global-bash || exit 1

archive /etc/greetd/config.toml
sudo chown -R 0:0 global-greetd
sudo stow --target=/ global-greetd || exit 1

sudo chown -R 0:0 global-aliases
sudo stow --target=/ global-aliases || exit 1
