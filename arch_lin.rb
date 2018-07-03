#!/usr/bin/ruby
puts "Hi, running upgrade now using pacman"
system('sudo pacman -Syu')
puts "upgrade complete"

#installing basic tools

puts "Installing Git ZSH tweak-tool"
system('sudo pacman -S git zsh gnome-tweak-tool --noconfirm')

#changing wallpaper

puts "Setting nature wallpaper"
system('wget https://unsplash.com/photos/hFzIoD0F_i8/download\?force\=true -O /tmp/wallpaper.jpg')
system('sudo /usr/bin/gsettings set org.gnome.desktop.background picture-uri "file://tmp/wallpaper.jpg"')

#installing oh-my-zsh

puts "installing oh-my-zsh and beautifying ur linux terminal"
system('git clone https://github.com/robbyrussell/oh-my-zsh.git /tmp/.oh-my-zsh')
system('sh /.oh-my-zsh/tools/install.sh')
system('git clone https://github.com/geometry-zsh/geometry.git ~/.oh-my-zsh/custom/themes/geometry')
puts "Changing the theme to geometry"
filename =  File.expand_path("~/.zshrc")
puts filename
text = File.read(filename)
new_contents = text.gsub('ZSH_THEME="robbyrussell"','ZSH_THEME="geometry/geometry"')
File.open(filename,"w") do |file|
	file.puts new_contents
	file.puts "GEOMETRY_PROMPT_PLUGINS=(virtualenv docker_machine exec_time git) \nGEOMETRY_COLOR_PROMPT='green' \nGEOMETRY_COLOR_ROOT='red' \nGEOMETRY_COLOR_DIR='blue' \narchey"
end
puts "Terminal setup done"


#installing themes and additional tools.

puts "Setting up Arc theme, paper icon theme, firefox, docker"
system('sudo pacman -S arc-gtk-theme paper-icon-theme firefox docker')
puts "Installing Sublime Text"
system('curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg')
system('echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf')
system('sudo pacman -S sublime-text')
puts "Sublime installed"

#installing Libinput Guestures

puts "Installing Libinput Guestures"
system('sudo pacman -S xdotool wmctrl')
system('git clone https://github.com/bulletmark/libinput-gestures.git /tmp/libinput-gestures')
system('sudo ./tmp/libinput-gestures-setup install')
system('sudo gpasswd -a $USER input')
system('libinput-gestures-setup autostart & libinput-gestures-setup start')
puts "libinput setup done"


#BLACKARCH INSTALL
puts "Add Black arch repository ? Enter Y or N"
selection = gets.chomp
if(selection=='Y') then
	puts "BlackArch installing"
	system('wget https://blackarch.org/strap.sh -O /tmp/strap.sh')
	shasum = `sha1sum /tmp/strap.sh`.to_s
	if(shasum != "73aae423a31410e021ef1b8f1becd573d2bd17dc") then
		puts "hash not equal"
		exit(0)
	end
	system('chmod +x /tmp/strap.sh & sudo "sh /tmp/strap.sh"')
	puts "BlackArch install done repos are added"
end
puts "Things to do 1. Change theme to arc in tweak tool \n 2.Change Icon theme to paper-icon-theme \n 3.Change Dock to bottom  \n 4.change shell of the user using chsh command \n 5.Logout and Login again"
exit(0)