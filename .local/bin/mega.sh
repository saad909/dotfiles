prereq(){

	ping  -q -c 1 1.1.1.1 &&  notify-send "Internet is working"|| notify-send " No Internet"
	installed=$(isInstalled mega-cmd)
	if [ $installed != 1 ]
	then
		notify-send " mega-cmd not installed. Install it using yay" && exit

	fi


}
sync(){
	#Scripts Folder
#	mega-mkdir -p CCNA/ICND2; mega-sync ~/Videos/Course/ICND2/Notes
#	mega-mkdir -p CCNA/ICND1; mega-sync ~/Videos/Course/ICND1/Notes
#	mega-mkdir -p i3/scripts; mega-sync ~/.local/bin i3/scripts
	# mega-mkdir -p i3/config;mega-sync ~/.config i3/config
	#Documents Folder
#	mega-mkdir  Documents;mega-sync ~/Documents Documents
	# mega-mkdir -p  SoftwaresAndTricks;mega-sync /home/ExternalHDD/SoftwaresAndTricks SoftwaresAndTricks
	# notes
#	mega-mkdir  notes;mega-sync ~/notes
	mega-mkdir -p Documents; mega-sync ~/Documents Documents
	mega-mkdir -p SoftwaresAndTricks; mega-sync /home/ExternalHDD/SoftwaresAndTricks SoftwaresAndTricks
############DOT files #######################
	# Home dir
#	home=$(ls -la ~ | grep saad | grep -v "^d" |awk '{print "~/" $9}' )
#	mega-mkdir -p dotfiles/home; mega-sync $home dotfiles/home

# dot files {{{1

	# mega-mkdir -p dotfiles/config; mega-sync ~/.config dotfiles/config
	# # scripts
	# mega-mkdir -p dotfiles/scripts; mega-sync ~/.local/bin dotfiles/scripts
	# # fonts
	# mega-mkdir -p dotfiles/fonts;mega-sync /home/saad/.local/share/fonts dotfiles/fonts
# }}}



}
login(){

	username=$(echo "" |dmenu -p " Mega Username  ")
	userCheck=$(echo $username | grep "@" | grep "\.com" | wc -l)

	[ -z $username ] && exit
	if [  $userCheck -ne 1 ]
	then
		notify-send " Invalid Username"
		login
	fi


	password=$(echo "" |dmenu -P -p " Password   ")
	failed=$( mega-login $username $password | grep failed | wc -l )
	if [ $failed == 1  ]
	then
		notify-send " Invalid Credential"
		retry=$(echo "" | dmenu -p "Retry/Exit(r/e)  ")
		case $retry in

			r|retry|RETRY|Retry) login;;
			e|exit|Exit|EXIT) exit;;
		esac

	fi

	notify-send " Logged in successfully"
	notify-send " Syncing"
	sync

}
alreadyLogin(){

	check=$( mega-login | grep -i already |wc -l )
	if [ $check == 0 ]
	then
		login
	else
		notify-send " Already logged in"
		notify-send " Syncing"
		sync

	fi

}
prereq && alreadyLogin
