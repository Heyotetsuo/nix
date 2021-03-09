#!/usr/bin/env bash

####### INSTALLATIONS ########
install='install -y';
autoremove='autoremove';

if [[ "$OSTYPE" == "linux-gnu"* ]];
then
	pkg='sudo apt';
	pkgui='sudo apt';
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
	pkgui='brew cask';
	update='update';
	upgrade='upgrade';
	remove='remove';
elif [[ "$OSTYPE" == "freebsd"* ]];
then
	pkg='pkg';
	pkgui='pkg';
	update='update';
	upgrade='upgrade';
	remove='delete';
fi;

$pkg $update;
$pkg $upgrade;

# security
$pkg $install nmap;
$pkg $install wireshark;
$pkg $install hexedit;

# basics
$pkg $install tmux;
$pkg $install tree;

# web
$pkgui $install firefox;
$pkg $install links;

# development
$pkg $install nasm;
$pkg $install yasm;
$pkg $install python3;
$pkg $install node;
$pkg $install html-xml-utils;
$pkg $install jq;

# multimedia
$pkg $install imagemagick;
$pkg $install ffmpeg;
$pkg $install youtube-dlc;
$pkg $install mpv;
$pkg $install aria2c;
$pkg $install catt;
$pkg $install exiftool;

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
