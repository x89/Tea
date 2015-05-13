#!/bin/sh

teatime=6m #  6 minutes (as per ISO 3103)
alert="\E[31m" # color for alerts (default: red)
clear="\E[0m" # reset color

if [ -r "tea.flac" ]; then
    tea_file="tea.flac"
elif [ -r "tea.mp3" ]; then
    tea_file="tea.mp3"
else
     echo -e "${alert}EMERGENCY!!! YOU WILL GET NO TEA WARNING $clear"
fi

PrintUsage(){
echo "Defaults:"
echo "Brew 5 minutes with milk"
echo ""
echo "Options:"
echo "-t ISO 3103 tea"
echo "-s short brewing tea (i.e. green tea)"
echo "-l long brewing tea (i.e. herbal tea)"
echo "-m without milk"
echo "-c custom brewing time in seconds"
echo "-h or --help prints this"
exit 1
}

PrintDone(){ # JUST SOME ASCII FLUFF
echo ""
echo "   {  {     "
echo "    }  }    "
echo "  ,{--{-.   "
echo " (  }    )  "
echo " |\`-----´|_ "
echo " |       | \\ "
echo " |  Tea  | |"
echo " |       |_/"
echo " \\       /  "
echo "  \`-----´   "
}

commandpicker() {
    # Thanks to @moopie - github for this function
    if which mpv >/dev/null; then
       player="mpv"
    elif which mplayer >/dev/null; then
       player="mplayer -nogui"
    elif which vlc >/dev/null; then
       player="vlc -I dummy --play-and-exit"
    else
        echo "We couldn't find a way to output sound when your tea is ready!"
    fi
}

commandpicker

write_terminal() {
    for u in $(who | grep "^${USER} " | awk '{print $1":"$2}'); do
        a=$(echo "${u}" | cut -d: -f1,1)
        b=$(echo "${u}" | cut -d: -f2,2)
        echo $1 |write $a $b
    done
}

# Check for audio files
if [ -r "tea.flac" ]; then
    tea_file="tea.flac"
elif [ -r "tea.mp3" ]; then
    tea_file="tea.mp3"
else
    echo "EMERGENCY!!! YOU WILL GET NO TEA WARNING"
    echo "(this is because we couldn't find a sound file for you)"
    exit
fi

echo ""
while test $# -gt 0
do
case "$1" in

    -h)
        teahelp=1
    ;;
    

    --help)
        teahelp=1
    ;;

    -t)
        teatime="3m"
    ;;

    -l)
        teatime="4m"
    ;;

    -s)
        teatime="2m"
    ;;

    -m)
        milk=1;
    ;;

    -c)
        if [ $2 -gt 0 ] 2>/dev/null ; then
            teatime=$2
            echo "You are using a custom wait time: $2"
        else
            PrintUsage
        fi

    ;;

    0)  ;; # to catch any number, todo: move into -c option
    1)  ;;
    2)  ;;
    3)  ;;
    4)  ;;
    5)  ;;
    6)  ;;
    7)  ;;
    8)  ;;
    9)  ;;

     
    -*)
        echo "this option does not exist: $1"
        teahelp=1
    ;;

    *)
    ;;

esac
shift
done

if [ ! -z $teahelp ]; then
    if [ $teahelp -eq 1 ]; then
        PrintUsage
        exit 1
    fi
fi

echo "You are using $tea_file."
echo "Have no fear! None! You will be warned when your tea is ready."
sleep "$teatime"

$player $tea_file 1>&- 2>&- || \
echo "We couldn't play your tea file." &>/dev/null

if [ -z $milk ]; then
    PrintDone
    echo "BUT YOUR TEA IS NOW READY, PUT THE MILK IN NOW!!!!"
elif [ ! -z $milk ]; then
    PrintDone
    echo "BUT YOUR TEA IS NOW READY."
fi

write_terminal "tea.sh: Your tea is ready!"

echo -en "$alert"
$player $tea_file &>/dev/null || \
echo "We couldn't play your tea file." &>/dev/null
echo "YOUR TEA IS NOW READY, PUT THE MILK IN NOW!!!!"
echo -en "$clear"
