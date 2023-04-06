alias wifiOff="nmcli radio wifi off"
alias wifiOn="nmcli radio wifi on"
alias wifiNearby="nmcli device wifi list"
alias wifiList="nmcli c show"
alias wifiConn="nmcli d"
alias lf="ranger"
alias update="sudo pacman -Syyu && yay -Syu"
alias logout="pkill -u paul"
alias s="startx"
#alias ls='nnn -de'
alias hotspot="sudo sh create_ap wlp2s0 wlp2s0 arco mypass..."
alias connectonefist="sudo killall openvpn; sudo openvpn --config OVPN/OneFistConfig/file.ovpn --auth-user-pass OVPN/OneFistConfig/pass.txt"
alias connectsuwen="sudo killall openvpn; sudo openvpn --config OVPN/SuwenConfig/file.ovpn --auth-user-pass OVPN/SuwenConfig/pass.txt"

export NNN_FCOLORS='c1e28d2e006033f7c6d6abc4'

