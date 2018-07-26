#!/usr/bin/ruby
puts "Hi, running upgrade now using pacman"
system('sudo pacman -Syu')
puts "upgrade complete"

#installing oh-my-zsh

puts "installing oh-my-zsh and beautifying ur linux terminal"
system('git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh')
system('sh ~/.oh-my-zsh/tools/install.sh')
system('git clone https://github.com/geometry-zsh/geometry.git ~/.oh-my-zsh/custom/themes/geometry')
puts "Changing the theme to geometry"
filename =  File.expand_path("~/.zshrc")
puts filename
text = File.read(filename)
new_contents = text.gsub('ZSH_THEME="robbyrussell"','ZSH_THEME="geometry/geometry"')
File.open(filename,"w") do |file|
	file.puts new_contents
	file.puts "GEOMETRY_PROMPT_PLUGINS=(virtualenv docker_machine exec_time git) \nGEOMETRY_COLOR_PROMPT='green' \nGEOMETRY_COLOR_ROOT='red' \nGEOMETRY_COLOR_DIR='blue' \narchey3"
end
puts "Terminal setup done"

#installing themes and additional tools.

puts "Setting up Arc theme, paper icon theme, firefox, docker atom yaourt"
system('sudo pacman -S arc-gtk-theme paper-icon-theme firefox docker archey3 atom xfce4-terminal yaourt --noconfirm')
system('yaourt -S evopop-icon-theme slack-desktop gpmdp --noconfirm')
puts "installed essentials"

#installing Libinput Guestures

puts "Installing Libinput Guestures"
system('sudo pacman -S xdotool wmctrl')
system('git clone https://github.com/bulletmark/libinput-gestures.git /tmp/libinput-gestures')
system('sudo /tmp/libinput-gestures-setup install')
system('sudo gpasswd -a $USER input')
system('/tmp/libinput-gestures-setup autostart & /tmp/libinput-gestures-setup start')
puts "libinput setup done"

puts "Logout and Login again has Mac trackpad guestures and a new cool shell.\n Things to do \n \
	1. Change icon theme to evopop. \n 2. Change gtx theme to Arc \n 3. Setup plank and configure it to autostart from budgie menu. \n 4. Change the Wallpaper"

puts("add web_search plugin by adding it to .zshrc. You can search web using web-serch from terminal.")
