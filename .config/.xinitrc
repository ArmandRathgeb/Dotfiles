# Launch no matter what
~/.fehbg &
picom --corner-radius 10 --round-borders -b &
dunst &
xautolock -locker 'i3lock -i ~/Images/ThrawnBackground.png' -time 5

# If launching dwm uncomment the following
#
# This fixes some issues with java applications
# wmname LG3D
# export _JAVA_AWT_WM_NONREPARENTING=1
# export AWT_TOOLKIT=MToolkit
# slstatus &
# xbindkeys &
# exec dwm 

# For i3
exec i3

