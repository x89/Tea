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

sleep 300  # 5 minutes

mpv $tea_file &>/dev/null || \
mplayer -nogui $tea_file &>/dev/null\
vlc -I dummy $tea_file &>/dev/null #  Feel free to add more! 

