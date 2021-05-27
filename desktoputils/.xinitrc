# If launching dwm uncomment the following
#
# This fixes some issues with java applications
# wmname LG3D
# export _JAVA_AWT_WM_NONREPARENTING=1
# export AWT_TOOLKIT=MToolkit
# slstatus &
# exec dwm 
# xbindkeys &
# xfce4-screensaver &


# Launch no matter what
~/.fehbg &
picom --corner-radius 10 --round-borders -b &
dunst &

# For i3
exec i3

