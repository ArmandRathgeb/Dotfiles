# This fixes some issues with java applications
wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit

#Set the background
~/.fehbg &
# Requires picom-rounded-corners
picom --corner-radius 10 --round-borders -b &
# Start slstatus
slstatus &
dunst &
# Start my lock screen and screensaver
xfce4-screensaver &
exec dwm 
