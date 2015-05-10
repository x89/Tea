#!/bin/sh

if [ -r "tea.flac" ]; then
    tea_file="tea.flac"
elif [ -r "tea.mp3" ]; then
    tea_file="tea.mp3"
else
    echo "EMERGENCY!!! YOU WILL GET NO TEA WARNING"
fi

echo "You are using $tea_file."
echo "Have no fear! None! you will be warned when your tea is ready."

sleep 1  # 5 minutes

commandpicker() {
    if which mpv >/dev/null; then
       player="mpv"
    elif which mplayer >/dev/null; then
       player="mplayer -nogui"
    elif which vlc >/dev/null; then
       player="vlc -I dummy"
    fi
}

commandpicker

$player $tea_file &>/dev/null
