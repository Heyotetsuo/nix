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

yes | $pkg $update;
yes | $pkg $upgrade;

# basics
pkgs="tree tmux";

# web
pkgsui="firefox";
pkgs="$pkgs links aria2 telegram-cli";

# networking
pkgs="$pkgs net-tools";

# development
pkgs="$pkgs nasm yasm html-xml-utils jq";
pkgs="$pkgs python python3 python3-pip";
pkgs="$pkgs nodejs npm";

# multimedia
pkgs="$pkgs imagemagick ffmpeg youtube-dl mpv aria2 exiftool";

# network security -- careful with this on a company computer
pkgs="$pkgs nmap wireshark hexedit";

# execute installs
for p in $pkgs;
do
	if command -v $p >/dev/null;
	then
		echo "$p: already installed";
	else
		yes | $pkg install $p;
	fi;
done;
for p in $pkgsui;
do
	if command -v $p >/dev/null;
	then
		echo "$p: already installed";
	else
		yes | $pkgui install $p;
	fi;
done;

####### SECONDARY INSTALLS #######
if ! command -v catt >/dev/null;
then
	pip3 install catt;
fi;
if ! command -v catt >/dev/null;
then
	sudo npm install -g jshint;
fi;

####### CONFIGS ########
configs="vimrc tmux.conf";
for f in $configs;
do
	if ! [ -f ~/.$f ] || [ -z "$(grep "Manny Morales Config" ~/.$f)" ];
	then
		if [ $f == vimrc ];
		then
			echo '" Manny Morales Config' >> ~/.$f;
		else
			echo "# Manny Morales Config" >> ~/.$f;
		fi;
		cat $f >> ~/.$f;
	fi;
done;

####### DEV ENVIRONMENT ######
subdirs="bin clients docs backup";
for dir in $subdirs;
do
	# mkdir -vp ~/Desktop/mine/$dir;
	mkdir -vp ~/manny/$dir;
done;
