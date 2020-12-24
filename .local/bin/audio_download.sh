#!/bin/bash
link=$(xclip -selection c -o)
url=$(echo $link |  grep ".\com" | wc -l)
if [  $url -ne 1 ]
then
	notify-send "Invalid link"
	exit

fi

notify-send " Downloading started" && mkdir /home/ExternalHDD/Music; youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0 -o "/home/ExternalHDD/Music/%(title)s.%(ext)s" "$link" && notify-send " Downloading Completed"
