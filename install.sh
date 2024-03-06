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
  base-devel just strace \
  bash-completion \
  stow \
  most bat eza \
  fx jq jc gron \
  fzf zoxide fd ripgrep moreutils \
  neovim meld tree-sitter-cli \
  docker docker-compose \
  ruby lua jdk-openjdk \
  tmux yazi \
  weechat discord \
  mpv \
  rofi-emoji wtype \

echo 'Installing Chaotic AUR...'
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo '[chaotic-aur]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf

echo 'Installing AUR packages...'
pacman --noconfirm -Sy \
  rare

echo 'Installing nodenv...'
cwd=$(pwd)
nodenvdir=$HOME/.nodenv
git clone https://github.com/nodenv/nodenv.git $nodenvdir
cd $nodenvdir
src/configure
make -C src
mkdir plugins
git clone https://github.com/nodenv/node-build.git plugins/node-build
git clone https://github.com/nodenv/nodenv-update.git plugins/nodenv-update
git clone https://github.com/nodenv/nodenv-aliases.git plugins/nodenv-aliases
git clone https://github.com/nodenv/nodenv-default-packages.git plugins/nodenv-default-packages
cat <<- EOF > default-packages
	nodemon
EOF
cd $cwd
nodenv install 21.6.2
nodenv global 21

echo 'Setting up ssh...'
systemctl --user --now enabled ssh-agent
ssh-keygen -t ed25519 -f $HOME/.ssh/id_ed25519 -C 95945959+mesmere@users.noreply.github.com
ssh-add $HOME/.ssh/id_ed25519
mkdir -p $HOME/.config/git
sed -E 's/(.+?) (.+?) (.+?)/\3 \1 \2/' $HOME/.ssh/id_ed25519.pub > $HOME/.config/git/allowed_signers

echo 'Enabling docker...'
sudo systemctl enable docker.socket

echo 'Don\'t mount /tmp on tmpfs...'
sudo systemctl mask tmp.mount

echo 'Stowing configs...'
echo 'If this fails, you can run ./stow.sh manually as many times as you need to fix the problem.'
source ./stow.sh

echo 'Setting yazi as the default file manager...'
xdg-mime default yazi.desktop inode/directory

echo 'Done.'
echo 'Do a full restart now before launching anything.'
