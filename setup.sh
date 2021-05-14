#!/usr/bin/env bash

####### INSTALLATIONS ########
install='install -y';
autoremove='autoremove';

if [[ "$OSTYPE" == "linux-gnu"* ]];
then
	pkg='sudo apt';
	pkgui='sudo apt install';
	update='update';
	upgrade='upgrade';
	remove='remove';
elif [[ "$OSTYPE" == "darwin"* ]];
then
	if [ -z "$(which brew)" ];
	then
		url='https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh';
		/bin/bash -c "$( curl -fsSL $url )";
	fi
	pkg='brew';
	pkgui='brew install --cask';
	update='update';
	upgrade='upgrade';
	remove='remove';
elif [[ "$OSTYPE" == "freebsd"* ]];
then
	pkg='pkg';
	pkgui='pkg install';
	update='update';
	upgrade='upgrade';
	remove='delete';
fi;

$pkg $update;
$pkg $upgrade;

# basics
pkgs=(tree tmux);

# web
pkgsui=(firefox);
pkgs=(${pkgs[@]} links);

# development
pkgs=(${pkgs[@]} nasm yasm python3 node html-xml-utils jq);

# multimedia
pkgs=(${pkgs[@]} imagemagick ffmpeg youtube-dlc mpv aria2 exiftool);

# security -- careful with this on a company computer
# ${pkgs[@]}=($pkgs nmap wireshark hexedit);

# execute installs
yes | $pkg install ${pkgs[@]};
yes | $pkgui ${pkgsui[@]};

####### CONFIGS ########
cp -nv vimrc ~/.vimrc;
cp -nv zshrc ~/.zshrc;
cp -nv bashrc ~/.bashrc;
cp -nv tmux.conf ~/.tmux.conf;

####### DEV ENVIRONMENT ######
mkdir -vp ~/Desktop/mine/bin;
mkdir -vp ~/Desktop/mine/proj;
mkdir -vp ~/Desktop/mine/docs;
mkdir -vp ~/Desktop/mine/backup;
