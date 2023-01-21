#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
xrdb -load ~/.Xresources
awesome
