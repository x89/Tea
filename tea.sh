#!/bin/sh

alert="\E[31m" # color for alerts (default: red)
clear="\E[0m" # reset color

if [ -r "tea.flac" ]; then
    tea_file="tea.flac"
elif [ -r "tea.mp3" ]; then
    tea_file="tea.mp3"
else
     echo -e "${alert}EMERGENCY!!! YOU WILL GET NO TEA WARNING $clear"
fi

echo "You are using $tea_file."
echo "Have no fear! None! You will be warned when your tea is ready."

sleep 360 #  6 minutes

commandpicker() {
    # Thanks to @moopie - github for this function
    if which mpv >/dev/null; then
       player="mpv"
    elif which mplayer >/dev/null; then
       player="mplayer -nogui"
    elif which vlc >/dev/null; then
       player="vlc -I dummy"
    fi
}

commandpicker

echo -en "$alert"
$player $tea_file &>/dev/null || \
echo "We couldn't play your tea file." &>/dev/null
echo "YOUR TEA IS NOW READY, PUT THE MILK IN NOW!!!!"
echo -en "$clear"
