#!/bin/sh

TimeErrorCheck(){

    if [ ! -z $teatime ]; then
        echo "Not sure what kind of tea you are making."
        teahelp=1
    fi
}

PrintUsage(){
echo "Defaults:"
echo "Brew 5 minutes without milk"
echo ""
echo "Options:"
echo "-t ISO 3103 tea"
echo "-s short brewing tea (i.e. green tea)"
echo "-l long brewing tea (i.e. herbal tea)"
echo "-m with milk"
echo "-h or --help prints this"

exit 1
}

PrintDone(){
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
        TimeErrorCheck
        teatime=360
    ;;

    -l)
        TimeErrorCheck
        teatime=480
    ;;

    -s)
        TimeErrorCheck
        teatime=240
    ;;

    -m)
        milk=1;
    ;;

    -*)
        echo "this option does not exist: $1"
        teahelp=1
    ;;

    *)
        echo "What are you trying to do with: $1"
        teahelp=1
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

if [ -r "tea.flac" ]; then
    tea_file="tea.flac"
elif [ -r "tea.mp3" ]; then
    tea_file="tea.mp3"
else
    echo "EMERGENCY!!! YOU WILL GET NO TEA WARNING"
fi

echo "You are using $tea_file."
echo "Have no fear! None! You will be warned when your tea is ready."

sleep $teatime

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

$player $tea_file &>/dev/null || \
echo "We couldn't play your tea file." &>/dev/null

PrintDone
if [ -z $milk]; then
    echo "BUT YOUR TEA IS NOW READY, PUT THE MILK IN NOW!!!!"
elif [ ! -z $milk]; then
    echo "BUT YOUR TEA IS NOW READY."
fi

exit 0
