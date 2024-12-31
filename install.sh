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
  base-devel just strace lsof \
  bash-completion \
  stow \
  most bat eza ouch git-delta \
  fx jq jc gron \
  fzf zoxide fd ripgrep moreutils sad sd \
  helix meld tree-sitter-cli lazygit \
  docker docker-compose \
  ruby lua jdk-openjdk \
  tmux \
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
git clone https://github.com/nodenv/node-build-update-defs.git plugins/node-build-update-defs
git clone https://github.com/nodenv/nodenv-update.git plugins/nodenv-update
git clone https://github.com/nodenv/nodenv-aliases.git plugins/nodenv-aliases
git clone https://github.com/nodenv/nodenv-default-packages.git plugins/nodenv-default-packages
cat <<- EOF > default-packages
	nodemon
	typescript
EOF
cd $cwd
nodenv install 22.8.0
nodenv global 22

echo 'Installing userspace OOM killer...'
sudo pacman -S earlyoom systembus-notify
sudo systemctl enable --now earlyoom

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

echo 'Switch sorting locale to C...'
cat <<- EOF >> /etc/locale.conf
	LC_CTYPE=C.utf8
	LC_COLLATE=C.utf8
EOF

echo 'Stowing configs...'
echo 'If this fails, you can run ./stow.sh manually as many times as you need to fix the problem.'
source ./stow.sh

echo 'Setting yazi as the default file manager...'
xdg-mime default yazi.desktop inode/directory

echo 'Building deadbeef-mpris2-plugin-git...'
yay -S deadbeef-mpris2-plugin-git

echo 'Done.'
echo 'Do a full restart now before launching anything.'
