# Launch no matter what
export XSystem=1
~/.fehbg &
picom --experimental-backends --backend glx &
dunst &
xautolock -locker 'i3lock -B 25 -k --{inside,ring}-color=414f6b55 --{layout,time,date,greeter}-color=ffffff -p win' -time 10 &

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

