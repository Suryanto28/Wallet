
Debian
====================
This directory contains files used to package trbod/trbo-qt
for Debian-based Linux systems. If you compile trbod/trbo-qt yourself, there are some useful files here.

## trbo: URI support ##


trbo-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install trbo-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your trboqt binary to `/usr/bin`
and the `../../share/pixmaps/trbo128.png` to `/usr/share/pixmaps`

trbo-qt.protocol (KDE)

