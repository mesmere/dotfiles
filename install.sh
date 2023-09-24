#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
  echo 'Please run as root. exiting...'
  exit 1
fi

echo 'Upgrading full system...'
pacman-mirrors -c United_States
pacman -Syu

echo 'Installing packages...'
pacman --needed --noconfirm -S \
  base-devel \
  bash-completion \
  stow \
  most bat eza \
  jq jc gron \
  fd ripgrep \
  neovim

echo 'Installing Chaotic AUR...'
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo '[chaotic-aur]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf

echo 'Installing AUR packages...'
pacman --noconfirm -Sy \
  rare \
  nvm

echo 'Setting up ssh...'
systemctl --user --now enabled ssh-agent
ssh-keygen -t ed25519 -f $HOME/.ssh/id_ed25519 -C 95945959+mesmere@users.noreply.github.com
ssh-add $HOME/.ssh/id_ed25519
mkdir -p $HOME/.config/git
sed -E 's/(.+?) (.+?) (.+?)/\3 \1 \2/' $HOME/.ssh/id_ed25519.pub > $HOME/.config/git/allowed_signers

echo 'Stowing configs...'
echo 'If this fails, you can run ./stow.sh manually as many times as you need to fix the problem.'
source ./stow.sh

echo 'Done.'
