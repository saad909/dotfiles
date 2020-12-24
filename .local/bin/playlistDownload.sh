#fileType=bash
link=$(xclip -selection c -o)
url=$(echo $link |  grep "you" | wc -l)
# url=$(echo $link |  grep "www\." | wc -l)
# if [ $url -eq 0 ]
# then
# 	url=$(echo $link |  grep "yout\." | wc -l)
# fi
Invalid(){

if [  $url -ne 1 ]
then
	notify-send "Invalid link"
	exit

fi

}
playlist(){
	title=$(echo ""| dmenu -p "Playlist Title" )


	# notify-send  " Playlist is downloading!!"
	notify-send "Playlist Download started in '$HOME/Videos/$title'"
	echo $link >> ~/Videos/Playlists/playlist.txt
	mkdir  -p ~/Videos/Playlists/"$title";cd ~/Videos/Playlists/"$title";youtube-dl -cit $link
	notify-send  " Playlist downloaded successfully"
}
video(){
	notify-send  " Video is downloading!!"
	mkdir -p ~/Videos/;cd ~/Videos/generalVideos ;youtube-dl $link
	echo $link >> ~/Videos/generalVideos/videos.txt ;notify-send  " Video downloaded successfully"
	# mkdir -p ~/Videos/;cd ~/Videos;youtube-dl -cit $link
	# notify-send " Video downloaded succesfully"

	exit
}
videoOrPlaylist(){
	isPlaylist=$(echo $link | grep list | wc -l)
	if [ $isPlaylist -eq 1 ]
	then
		playlist
	else
		video
	fi

}
prereq(){

	notInstalled=$(isInstalled youtube-dl)
	if [ $notInstalled -ne 1  ]
	then
		echo 123 | sudo -S pacman -S youtube-dl
	fi

}
if [ $link == ""  ]

then
	exit
else
	Invalid
	prereq
	videoOrPlaylist && exit
fi
